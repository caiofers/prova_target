import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/usecases/get_logged_user.dart';
import '../states/records.store.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final _createRecordFormKey = GlobalKey<FormState>();
  final _editRecordFormKey = GlobalKey<FormState>();
  final _createRecordFocusNode = FocusNode();

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RecordsStore recordsStore = RecordsStore();
    recordsStore.getAllRecords(context);

    void openDeletePopUp(BuildContext context, String recordId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Observer(
            builder: (_) => AlertDialog(
              title: const Text('Excluir registro de texto'),
              content: const Text('O registro será excluído permanentemente. Ainda deseja excluir?'),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton.icon(
                  style: const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Não'),
                ),
                ElevatedButton.icon(
                  autofocus: true,
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () async {
                    await recordsStore.deleteRecord(context, recordId);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  icon: recordsStore.isDeletionInProgress
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Icon(Icons.delete),
                  label: const Text('Sim'),
                ),
              ],
            ),
          );
        },
      );
    }

    void openEditPopUp(BuildContext context, String recordId, String currentText) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          recordsStore.editRecordTextController.text = currentText;
          return Observer(
            builder: (_) => AlertDialog(
              title: const Text('Editar registro de texto'),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              content: Form(
                key: _editRecordFormKey,
                child: TextFormField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  controller: recordsStore.editRecordTextController,
                  decoration: const InputDecoration(
                    hintText: "Digite seu texto",
                    hintStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                    contentPadding: EdgeInsets.all(15.0),
                  ),
                  onEditingComplete: () async {
                    if (_editRecordFormKey.currentState?.validate() ?? false) {
                      await recordsStore.editRecord(context, recordId);
                      if (context.mounted) Navigator.of(context).pop();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite seu texto.';
                    }

                    return null;
                  },
                ),
              ),
              actions: [
                TextButton.icon(
                  style: const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Cancelar'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await recordsStore.editRecord(context, recordId);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  icon: recordsStore.isUpdateInProgress
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator())
                      : const Icon(Icons.check),
                  label: const Text('Confirmar'),
                ),
              ],
            ),
          );
        },
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(29, 77, 98, 1),
            Color.fromRGBO(46, 148, 142, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Consumer<GetLoggedUser>(builder: (context, getLoggedUser, _) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<User?>(
              future: getLoggedUser.execute(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('Nenhum usuário logado'));
                } else {
                  final user = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        style: const TextStyle(color: Colors.white, fontSize: 18),
                                        children: [
                                          const TextSpan(
                                            text: "Olá, ",
                                          ),
                                          TextSpan(
                                            text: user.name,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const TextSpan(
                                            text: "!",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Esses são os seus registros:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Observer(
                                builder: (_) => Container(
                                  height: 250,
                                  alignment: Alignment.topCenter,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: Stack(
                                    children: [
                                      SingleChildScrollView(
                                        child: ListView.builder(
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: recordsStore.records.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              margin: const EdgeInsets.symmetric(vertical: 2),
                                              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                              color: const Color.fromARGB(31, 4, 4, 4),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      recordsStore.records[index].text,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      String selectedRecordId = recordsStore.records[index].id;
                                                      String selectedRecordCurrentText =
                                                          recordsStore.records[index].text;
                                                      openEditPopUp(
                                                          context, selectedRecordId, selectedRecordCurrentText);
                                                    },
                                                    icon: const Icon(Icons.edit),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      String selectedRecordId = recordsStore.records[index].id;
                                                      openDeletePopUp(context, selectedRecordId);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      if (recordsStore.isLoadingAllRecords)
                                        const Center(
                                          child: SizedBox(
                                            width: 24.0,
                                            height: 24.0,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Observer(
                                builder: (_) => Form(
                                  key: _createRecordFormKey,
                                  child: Stack(
                                    children: [
                                      TextFormField(
                                        focusNode: _createRecordFocusNode,
                                        enabled: !recordsStore.isCreationInProgress,
                                        textAlign: TextAlign.center,
                                        controller: recordsStore.createRecordTextController,
                                        decoration: const InputDecoration(
                                          hintText: "Digite seu texto",
                                          hintStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                                          contentPadding: EdgeInsets.all(15.0),
                                        ),
                                        onEditingComplete: () async {
                                          if ((_createRecordFormKey.currentState?.validate() ?? false) &&
                                              !recordsStore.isCreationInProgress) {
                                            await recordsStore.createRecord(context);

                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                              _createRecordFocusNode.requestFocus();
                                            });
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Por favor, digite seu texto.';
                                          }

                                          return null;
                                        },
                                      ),
                                      if (recordsStore.isCreationInProgress)
                                        const Positioned(
                                          top: 0.0,
                                          bottom: 0.0,
                                          right: 0.0,
                                          left: 0.0,
                                          child: Center(
                                            child: SizedBox(
                                              width: 24.0,
                                              height: 24.0,
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                          child: TextButton(
                            onPressed: () {
                              _launchURL("https://google.com.br");
                            },
                            child: const Text("Política de Privacidade"),
                          ),
                        ),
                        Observer(
                          builder: (context) {
                            if (recordsStore.errorMessage.isNotEmpty) {
                              WidgetsBinding.instance.addPostFrameCallback(
                                (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(recordsStore.errorMessage),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  recordsStore.setErrorMessage('');
                                },
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  );
                }
              }),
        );
      }),
    );
  }

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
