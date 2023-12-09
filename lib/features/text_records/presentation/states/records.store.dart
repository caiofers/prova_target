import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:prova_target/features/text_records/domain/entities/text_record.dart';
import 'package:prova_target/features/text_records/domain/exceptions/record_operations_exception.dart';
import 'package:prova_target/features/text_records/domain/repository_protocols/records_repository_protocol.dart';
import 'package:prova_target/features/text_records/domain/usecases/create_record.dart';
import 'package:prova_target/features/text_records/domain/usecases/delete_record.dart';
import 'package:prova_target/features/text_records/domain/usecases/get_all_records.dart';
import 'package:prova_target/features/text_records/domain/usecases/update_record.dart';
import 'package:provider/provider.dart';

part 'records.store.g.dart';

class RecordsStore = RecordsStoreBase with _$RecordsStore;

abstract class RecordsStoreBase with Store {
  RecordsStoreBase();

  final TextEditingController _createRecordTextController = TextEditingController();
  final TextEditingController _editRecordTextController = TextEditingController();

  TextEditingController get createRecordTextController => _createRecordTextController;
  TextEditingController get editRecordTextController => _editRecordTextController;

  dispose() {
    _createRecordTextController.dispose();
    _editRecordTextController.dispose();
  }

  @observable
  List<TextRecord> _records = [];

  @observable
  String _recordText = '';

  @observable
  bool isLoadingAllRecords = false;
  @observable
  bool isCreationInProgress = false;
  @observable
  bool isUpdateInProgress = false;
  @observable
  bool isDeletionInProgress = false;

  @observable
  String errorMessage = '';

  @observable
  bool isDeletePopupVisible = false;

  @computed
  List<TextRecord> get records => _records;

  @action
  void setRecordText(String value) => _recordText = value;

  @action
  void setErrorMessage(String value) => errorMessage = value;

  @action
  Future<void> getAllRecords(BuildContext context) async {
    try {
      isLoadingAllRecords = true;
      if (context.mounted) {
        RecordsRepositoryProtocol recordRepository = _getRepository(context);
        _records = await GetAllRecords(recordRepository).execute();
      } else {
        throw Exception();
      }
      isLoadingAllRecords = false;
      setErrorMessage('');
    } on RecordOperationsException catch (e) {
      isLoadingAllRecords = false;
      setErrorMessage(e.message);
    } catch (e) {
      isLoadingAllRecords = false;
      setErrorMessage("Erro inesperado, entre em contato com o dev.");
    }
  }

  @action
  Future<void> createRecord(BuildContext context) async {
    try {
      isCreationInProgress = true;
      if (context.mounted) {
        RecordsRepositoryProtocol recordRepository = _getRepository(context);
        await CreateRecord(recordRepository).execute(_createRecordTextController.text);
        _createRecordTextController.clear();
        _records = await GetAllRecords(recordRepository).execute();
      } else {
        throw Exception();
      }
      isCreationInProgress = false;
      setErrorMessage('');
    } on RecordOperationsException catch (e) {
      isCreationInProgress = false;
      setErrorMessage(e.message);
    } catch (e) {
      isCreationInProgress = false;
      setErrorMessage("Erro inesperado, entre em contato com o dev.");
    }
  }

  @action
  Future<void> deleteRecord(BuildContext context, String recordId) async {
    try {
      isDeletionInProgress = true;
      if (context.mounted) {
        RecordsRepositoryProtocol recordRepository = _getRepository(context);
        await DeleteRecord(recordRepository).execute(recordId);
        _records = await GetAllRecords(recordRepository).execute();
      } else {
        throw Exception();
      }
      isDeletionInProgress = false;
      setErrorMessage('');
    } on RecordOperationsException catch (e) {
      isDeletionInProgress = false;
      setErrorMessage(e.message);
    } catch (e) {
      isDeletionInProgress = false;
      setErrorMessage("Erro inesperado, entre em contato com o dev.");
    }
  }

  @action
  Future<void> editRecord(BuildContext context, String recordId) async {
    try {
      isUpdateInProgress = true;
      if (context.mounted) {
        RecordsRepositoryProtocol recordRepository = _getRepository(context);
        await UpdateRecord(recordRepository).execute(recordId, editRecordTextController.text);
        _editRecordTextController.clear();
        _records = await GetAllRecords(recordRepository).execute();
      } else {
        throw Exception();
      }
      isUpdateInProgress = false;
      setErrorMessage('');
    } on RecordOperationsException catch (e) {
      isUpdateInProgress = false;
      setErrorMessage(e.message);
    } catch (e) {
      isUpdateInProgress = false;
      setErrorMessage("Erro inesperado, entre em contato com o dev.");
    }
  }

  RecordsRepositoryProtocol _getRepository(BuildContext context) {
    return Provider.of<RecordsRepositoryProtocol>(context, listen: false);
  }
}
