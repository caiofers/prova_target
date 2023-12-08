import 'package:prova_target/features/text_records/domain/entities/text_record.dart';

import '../repository_protocols/records_repository_protocol.dart';

class GetRecord {
  final RecordsRepositoryProtocol _repository;

  GetRecord(this._repository);

  Future<TextRecord> execute(String id) async {
    return await _repository.getRecord(id);
  }
}
