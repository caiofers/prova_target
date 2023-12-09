import '../repository_protocols/records_repository_protocol.dart';
import '../entities/text_record.dart';

class GetAllRecords {
  final RecordsRepositoryProtocol _repository;

  GetAllRecords(this._repository);

  Future<List<TextRecord>> execute() async {
    return await _repository.getAllRecords().then((value) => value.reversed.toList());
  }
}
