// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecordsStore on RecordsStoreBase, Store {
  Computed<List<TextRecord>>? _$recordsComputed;

  @override
  List<TextRecord> get records =>
      (_$recordsComputed ??= Computed<List<TextRecord>>(() => super.records,
              name: 'RecordsStoreBase.records'))
          .value;

  late final _$_recordsAtom =
      Atom(name: 'RecordsStoreBase._records', context: context);

  @override
  List<TextRecord> get _records {
    _$_recordsAtom.reportRead();
    return super._records;
  }

  @override
  set _records(List<TextRecord> value) {
    _$_recordsAtom.reportWrite(value, super._records, () {
      super._records = value;
    });
  }

  late final _$_recordTextAtom =
      Atom(name: 'RecordsStoreBase._recordText', context: context);

  @override
  String get _recordText {
    _$_recordTextAtom.reportRead();
    return super._recordText;
  }

  @override
  set _recordText(String value) {
    _$_recordTextAtom.reportWrite(value, super._recordText, () {
      super._recordText = value;
    });
  }

  late final _$isLoadingAllRecordsAtom =
      Atom(name: 'RecordsStoreBase.isLoadingAllRecords', context: context);

  @override
  bool get isLoadingAllRecords {
    _$isLoadingAllRecordsAtom.reportRead();
    return super.isLoadingAllRecords;
  }

  @override
  set isLoadingAllRecords(bool value) {
    _$isLoadingAllRecordsAtom.reportWrite(value, super.isLoadingAllRecords, () {
      super.isLoadingAllRecords = value;
    });
  }

  late final _$isCreationInProgressAtom =
      Atom(name: 'RecordsStoreBase.isCreationInProgress', context: context);

  @override
  bool get isCreationInProgress {
    _$isCreationInProgressAtom.reportRead();
    return super.isCreationInProgress;
  }

  @override
  set isCreationInProgress(bool value) {
    _$isCreationInProgressAtom.reportWrite(value, super.isCreationInProgress,
        () {
      super.isCreationInProgress = value;
    });
  }

  late final _$isUpdateInProgressAtom =
      Atom(name: 'RecordsStoreBase.isUpdateInProgress', context: context);

  @override
  bool get isUpdateInProgress {
    _$isUpdateInProgressAtom.reportRead();
    return super.isUpdateInProgress;
  }

  @override
  set isUpdateInProgress(bool value) {
    _$isUpdateInProgressAtom.reportWrite(value, super.isUpdateInProgress, () {
      super.isUpdateInProgress = value;
    });
  }

  late final _$isDeletionInProgressAtom =
      Atom(name: 'RecordsStoreBase.isDeletionInProgress', context: context);

  @override
  bool get isDeletionInProgress {
    _$isDeletionInProgressAtom.reportRead();
    return super.isDeletionInProgress;
  }

  @override
  set isDeletionInProgress(bool value) {
    _$isDeletionInProgressAtom.reportWrite(value, super.isDeletionInProgress,
        () {
      super.isDeletionInProgress = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'RecordsStoreBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isDeletePopupVisibleAtom =
      Atom(name: 'RecordsStoreBase.isDeletePopupVisible', context: context);

  @override
  bool get isDeletePopupVisible {
    _$isDeletePopupVisibleAtom.reportRead();
    return super.isDeletePopupVisible;
  }

  @override
  set isDeletePopupVisible(bool value) {
    _$isDeletePopupVisibleAtom.reportWrite(value, super.isDeletePopupVisible,
        () {
      super.isDeletePopupVisible = value;
    });
  }

  late final _$getAllRecordsAsyncAction =
      AsyncAction('RecordsStoreBase.getAllRecords', context: context);

  @override
  Future<void> getAllRecords(BuildContext context) {
    return _$getAllRecordsAsyncAction.run(() => super.getAllRecords(context));
  }

  late final _$createRecordAsyncAction =
      AsyncAction('RecordsStoreBase.createRecord', context: context);

  @override
  Future<void> createRecord(BuildContext context) {
    return _$createRecordAsyncAction.run(() => super.createRecord(context));
  }

  late final _$deleteRecordAsyncAction =
      AsyncAction('RecordsStoreBase.deleteRecord', context: context);

  @override
  Future<void> deleteRecord(BuildContext context, String recordId) {
    return _$deleteRecordAsyncAction
        .run(() => super.deleteRecord(context, recordId));
  }

  late final _$editRecordAsyncAction =
      AsyncAction('RecordsStoreBase.editRecord', context: context);

  @override
  Future<void> editRecord(BuildContext context, String recordId) {
    return _$editRecordAsyncAction
        .run(() => super.editRecord(context, recordId));
  }

  late final _$RecordsStoreBaseActionController =
      ActionController(name: 'RecordsStoreBase', context: context);

  @override
  void setRecordText(String value) {
    final _$actionInfo = _$RecordsStoreBaseActionController.startAction(
        name: 'RecordsStoreBase.setRecordText');
    try {
      return super.setRecordText(value);
    } finally {
      _$RecordsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String value) {
    final _$actionInfo = _$RecordsStoreBaseActionController.startAction(
        name: 'RecordsStoreBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$RecordsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingAllRecords: ${isLoadingAllRecords},
isCreationInProgress: ${isCreationInProgress},
isUpdateInProgress: ${isUpdateInProgress},
isDeletionInProgress: ${isDeletionInProgress},
errorMessage: ${errorMessage},
isDeletePopupVisible: ${isDeletePopupVisible},
records: ${records}
    ''';
  }
}
