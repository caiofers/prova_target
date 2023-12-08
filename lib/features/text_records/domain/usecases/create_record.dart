import '../repository_protocols/records_repository_protocol.dart';

class CreateRecord {
  final RecordsRepositoryProtocol _repository;

  CreateRecord(this._repository);

  Future<String> execute(String text) async {
    return await _repository.createRecord(text);
  }
}
