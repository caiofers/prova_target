import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target/features/text_records/data/repositories/records_repository_mock.dart';
import 'package:prova_target/features/text_records/domain/entities/text_record.dart';
import 'package:prova_target/features/text_records/domain/repository_protocols/records_repository_protocol.dart';
import 'package:prova_target/features/text_records/domain/usecases/create_record.dart';
import 'package:prova_target/features/text_records/domain/usecases/get_record.dart';

void main() {
  late RecordsRepositoryProtocol repository;
  late CreateRecord createRecord;
  late GetRecord usecase;
  group(
    'get one record tests',
    () {
      setUp(() {
        repository = RecordsRepositoryMock();
        createRecord = CreateRecord(repository);
        usecase = GetRecord(repository);
      });
      test(
        'sucess to get the correct record',
        () async {
          String recordId = await createRecord.execute("testedeumso");
          TextRecord record = await usecase.execute(recordId);
          assert(record.text == "testedeumso");
        },
      );
    },
  );
}
