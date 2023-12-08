import 'package:prova_target/features/text_records/domain/entities/text_record.dart';
import 'package:uuid/uuid.dart';

import '../../domain/exceptions/record_operations_exception.dart';
import '../../domain/repository_protocols/records_repository_protocol.dart';
import '../models/text_record_model.dart';

class RecordsRepositoryMock implements RecordsRepositoryProtocol {
  final int _delayInMilliseconds = 500;
  List<Map<String, String>> _allRecords = [];

  @override
  Future<String> createRecord(String text) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    String recordId = const Uuid().v1();
    Map<String, String> recordMap = {"id": recordId, "text": text};
    _allRecords.add(recordMap);
    return recordId;
  }

  @override
  Future<List<TextRecord>> getAllRecords() async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));
    return _allRecords.map((e) => TextRecordModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<TextRecord> getRecord(String id) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));
    Map<String, String> recordMap = _allRecords.firstWhere((element) => element["id"] == id);
    return TextRecordModel.fromJson(recordMap).toEntity();
  }

  @override
  Future<void> deleteRecord(String id) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    _allRecords.removeWhere((element) => element["id"] == id);
  }

  Future<void> deleteAllRecords() async {
    _allRecords = [];
  }

  @override
  Future<void> updateRecord(String id, String text) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    Map<String, String> recordMap = {"id": id, "text": text};

    for (int i = 0; i < _allRecords.length; i++) {
      if (_allRecords[i]['id'] == id) {
        _allRecords[i] = recordMap;
        break;
      } else {
        if (i == _allRecords.length - 1) {
          throw RecordOperationsException("Registro não encontrado");
        }
      }
    }
  }
}
