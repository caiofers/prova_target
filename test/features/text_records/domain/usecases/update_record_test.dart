import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target/features/text_records/data/repositories/records_repository_mock.dart';
import 'package:prova_target/features/text_records/domain/entities/text_record.dart';
import 'package:prova_target/features/text_records/domain/repository_protocols/records_repository_protocol.dart';
import 'package:prova_target/features/text_records/domain/usecases/create_record.dart';
import 'package:prova_target/features/text_records/domain/usecases/get_record.dart';
import 'package:prova_target/features/text_records/domain/usecases/update_record.dart';

void main() {
  late RecordsRepositoryProtocol repository;
  late UpdateRecord usecase;
  late CreateRecord createRecord;
  late GetRecord getRecord;
  group(
    'create records tests',
    () {
      setUp(() {
        repository = RecordsRepositoryMock();
        usecase = UpdateRecord(repository);
        createRecord = CreateRecord(repository);
        getRecord = GetRecord(repository);
      });
      test(
        'sucess to create record',
        () async {
          String recordCreatedId = await createRecord.execute("test");
          await usecase.execute(recordCreatedId, "oi");
          TextRecord updatedRecord = await getRecord.execute(recordCreatedId);
          expect(updatedRecord.text, 'oi');
        },
      );
    },
  );
}
