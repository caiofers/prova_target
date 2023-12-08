import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/repository_protocols/auth_repository_protocol.dart';
import '../state/login.store.dart';
import '../widgets/custom_text_form_field_label.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginUsernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _loginButtonFocus = FocusNode();
  final TextEditingController _loginUsernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  dispose() {
    _loginUsernameFocus.dispose();
    _passwordFocus.dispose();
    _loginUsernameController.dispose();
    _passwordController.dispose();
    _loginButtonFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = Provider.of<AuthRepositoryProtocol>(context, listen: false);
    final LoginStore loginStore = LoginStore(authRepository);

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextFormFieldLabel(
                        text: "Usuário",
                      ),
                      Observer(
                        builder: (_) => TextFormField(
                          focusNode: _loginUsernameFocus,
                          controller: _loginUsernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          },
                          onChanged: loginStore.setLoginUsername,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, digite um nome de usuário.';
                            }
                            if (value.length > 20) {
                              return 'O nome de usuário não pode ter mais de 20 caracteres.';
                            }
                            if (value.endsWith(' ')) {
                              return 'O nome de usuário não pode terminar com espaço.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const CustomTextFormFieldLabel(
                        text: "Senha",
                      ),
                      Observer(
                        builder: (_) => TextFormField(
                          focusNode: _passwordFocus,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_loginButtonFocus);
                          },
                          onChanged: loginStore.setPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, digite uma senha.';
                            }
                            if (value.length < 2) {
                              return 'A senha deve ter pelo menos 2 caracteres.';
                            }
                            if (value.length > 20) {
                              return 'A senha não pode ter mais de 20 caracteres.';
                            }
                            if (value.endsWith(' ')) {
                              return 'A senha não pode terminar com espaço.';
                            }
                            if (!_isAlphanumeric(value)) {
                              return 'A senha deve conter apenas letras e números.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: 120,
                        child: Observer(builder: (_) {
                          return ElevatedButton(
                            focusNode: _loginButtonFocus,
                            onPressed: loginStore.isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      loginStore.loginUser(context);
                                    }
                                  },
                            child: loginStore.isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text("Entrar"),
                          );
                        }),
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
                    if (loginStore.errorMessage.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loginStore.errorMessage),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          loginStore.setErrorMessage('');
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isAlphanumeric(String value) {
    final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    return alphanumeric.hasMatch(value);
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
