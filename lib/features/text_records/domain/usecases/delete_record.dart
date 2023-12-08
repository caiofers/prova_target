import '../repository_protocols/records_repository_protocol.dart';

class DeleteRecord {
  final RecordsRepositoryProtocol _repository;

  DeleteRecord(this._repository);

  Future<void> execute(String id) async {
    return await _repository.deleteRecord(id);
  }
}
