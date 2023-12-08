import '../../domain/entities/text_record.dart';

class TextRecordModel {
  String _id;
  String _text;

  TextRecordModel(this._id, this._text);

  factory TextRecordModel.fromJson(dynamic json) {
    return TextRecordModel(
      json['id'] as String,
      json['text'] as String,
    );
  }

  factory TextRecordModel.fromEntity(TextRecord textRecord) {
    return TextRecordModel(textRecord.id, textRecord.text);
  }

  TextRecord toEntity() {
    return TextRecord(_id, _text);
  }

  Map<String, Object?> toJson() {
    return {
      'id': _id,
      'text': _text,
    };
  }
}
