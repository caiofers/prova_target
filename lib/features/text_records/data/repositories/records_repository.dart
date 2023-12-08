import 'package:prova_target/features/auth/data/services/auth_service_in_memory_storage.dart';
import 'package:prova_target/features/text_records/data/models/text_record_model.dart';
import 'package:prova_target/features/text_records/domain/entities/text_record.dart';
import 'package:prova_target/features/text_records/domain/exceptions/record_operations_exception.dart';

import '../../domain/repository_protocols/records_repository_protocol.dart';
import '../services/records_shared_preferences_storage_service.dart';

class RecordsRepository implements RecordsRepositoryProtocol {
  final RecordsSharedPreferencesStorageService _storageService =
      RecordsSharedPreferencesStorageService('records_storage_key');

  @override
  Future<String> createRecord(String text) async {
    return await _storageService.createRecord(text);
  }

  @override
  Future<void> deleteRecord(String id) async {
    await _storageService.deleteRecord(id);
  }

  @override
  Future<List<TextRecord>> getAllRecords() async {
    List<Map<String, String>> recordsMap = await _storageService.getAllRecords();
    return recordsMap.map((e) => TextRecordModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<TextRecord> getRecord(String id) async {
    return TextRecordModel.fromJson(await _storageService.getRecord(id)).toEntity();
  }

  @override
  Future<void> updateRecord(String id, String text) async {
    try {
      _storageService.updateRecord(id, text);
    } on ServiceException catch (e) {
      if (e.message == "NOT_FOUND") {
        throw RecordOperationsException("Registro não encontrado");
      }
    }
  }
}
