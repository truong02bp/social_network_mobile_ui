// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    content: json['content'] as String?,
    sender: Messenger.fromJson(json['sender'] as Map<String, dynamic>),
    id: json['id'] as int,
    createdDate: DateTime.parse(json['createdDate'] as String),
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
    medias: (json['medias'] as List<dynamic>?)
        ?.map((e) => MessageMedia.fromJson(e as Map<String, dynamic>))
        .toList(),
    interactions: (json['interactions'] as List<dynamic>?)
        ?.map((e) => MessageInteraction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate.toIso8601String(),
      'content': instance.content,
      'sender': instance.sender.toJson(),
      'type': _$MessageTypeEnumMap[instance.type],
      'medias': instance.medias?.map((e) => e.toJson()).toList(),
      'interactions': instance.interactions?.map((e) => e.toJson()).toList(),
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
  MessageType.MEDIA: 'MEDIA',
};
