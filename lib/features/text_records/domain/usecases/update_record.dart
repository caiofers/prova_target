import '../repository_protocols/records_repository_protocol.dart';

class UpdateRecord {
  final RecordsRepositoryProtocol _repository;

  UpdateRecord(this._repository);

  Future<void> execute(String id, String text) async {
    return await _repository.updateRecord(id, text);
  }
}
