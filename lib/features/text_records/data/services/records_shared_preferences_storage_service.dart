import 'dart:convert';

import 'package:prova_target/features/auth/data/services/auth_service_in_memory_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum StorageErrors {
  notFound;

  String get code {
    switch (this) {
      case StorageErrors.notFound:
        return 'RECORD_NOT_FOUND';
    }
  }
}

class RecordsSharedPreferencesStorageService {
  final String _storageKey;
  final int _delayInMilliseconds = 1000;

  RecordsSharedPreferencesStorageService(this._storageKey);

  Future<String> createRecord(String text) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    String recordId = const Uuid().v1();
    Map<String, String> recordMap = {"id": recordId, "text": text};

    List<Map<String, String>> allRecords = await getAllRecords();
    allRecords.add(recordMap);
    String allRecordsJson = jsonEncode(allRecords);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_storageKey, allRecordsJson);

    return recordId;
  }

  Future<List<Map<String, String>>> getAllRecords() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? json = sharedPreferences.getString(_storageKey);

    if (json != null) {
      return jsonDecode(json);
    } else {
      return [];
    }
  }

  Future<void> deleteRecord(String id) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    List<Map<String, String>> allRecords = await getAllRecords();
    allRecords.removeWhere((element) => element["id"] == id);
    String allRecordsJson = jsonEncode(allRecords);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_storageKey, allRecordsJson);
  }

  Future<Map<String, String>> getRecord(String id) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    List<Map<String, String>> allRecords = await getAllRecords();
    try {
      return allRecords.firstWhere((element) => element["id"] == id);
    } on ServiceException {
      throw ServiceException(StorageErrors.notFound.code);
    }
  }

  Future<void> deleteAllRecords() async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_storageKey);
  }

  Future<void> updateRecord(String id, String text) async {
    await Future.delayed(Duration(milliseconds: _delayInMilliseconds));

    Map<String, String> recordMap = {"id": id, "text": text};

    List<Map<String, String>> allRecords = await getAllRecords();

    for (int i = 0; i < allRecords.length; i++) {
      if (allRecords[i]['id'] == id) {
        allRecords[i] = recordMap;
        break;
      } else {
        if (i == allRecords.length - 1) {
          throw ServiceException(StorageErrors.notFound.code);
        }
      }
    }

    String allRecordsJson = jsonEncode(allRecords);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_storageKey, allRecordsJson);
  }
}
