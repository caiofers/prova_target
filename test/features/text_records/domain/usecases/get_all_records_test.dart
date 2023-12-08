import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target/features/text_records/data/repositories/records_repository_mock.dart';
import 'package:prova_target/features/text_records/domain/entities/text_record.dart';
import 'package:prova_target/features/text_records/domain/repository_protocols/records_repository_protocol.dart';
import 'package:prova_target/features/text_records/domain/usecases/create_record.dart';
import 'package:prova_target/features/text_records/domain/usecases/get_all_records.dart';

void main() {
  late RecordsRepositoryProtocol repository;
  late CreateRecord createRecord;
  late GetAllRecords usecase;
  group(
    'get records tests',
    () {
      setUp(() {
        repository = RecordsRepositoryMock();
        createRecord = CreateRecord(repository);
        usecase = GetAllRecords(repository);
      });
      test(
        'sucess to get all records',
        () async {
          await createRecord.execute("test");
          await createRecord.execute("test1");
          await createRecord.execute("test2");
          List<TextRecord> records = await usecase.execute();
          assert(records.length == 3);
        },
      );
    },
  );
}
