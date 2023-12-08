import 'package:flutter_test/flutter_test.dart';
import 'package:prova_target/features/text_records/data/repositories/records_repository_mock.dart';
import 'package:prova_target/features/text_records/domain/entities/text_record.dart';
import 'package:prova_target/features/text_records/domain/repository_protocols/records_repository_protocol.dart';
import 'package:prova_target/features/text_records/domain/usecases/create_record.dart';
import 'package:prova_target/features/text_records/domain/usecases/get_all_records.dart';

void main() {
  late RecordsRepositoryProtocol repository;
  late CreateRecord usecase;
  late GetAllRecords getAllRecords;
  group(
    'create records tests',
    () {
      setUp(() {
        repository = RecordsRepositoryMock();
        usecase = CreateRecord(repository);
        getAllRecords = GetAllRecords(repository);
      });
      test(
        'sucess to create record',
        () async {
          List<TextRecord> records = await getAllRecords.execute();
          assert(records.isEmpty);
          await usecase.execute("Texto teste");
          List<TextRecord> updatedRecords = await getAllRecords.execute();
          assert(updatedRecords.isNotEmpty);
        },
      );
    },
  );
}
