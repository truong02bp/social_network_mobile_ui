// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) {
  return MessageDto(
    content: json['content'] as String,
    messengerId: json['messengerId'] as int,
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'messengerId': instance.messengerId,
      'type': _$MessageTypeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MessageTypeEnumMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.VIDEO: 'VIDEO',
};
