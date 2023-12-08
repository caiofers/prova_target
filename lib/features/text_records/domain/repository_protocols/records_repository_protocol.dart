import '../entities/text_record.dart';

abstract interface class RecordsRepositoryProtocol {
  Future<List<TextRecord>> getAllRecords();
  Future<TextRecord> getRecord(String id);
  Future<String> createRecord(String text);
  Future<void> updateRecord(String id, String text);
  Future<void> deleteRecord(String id);
}
