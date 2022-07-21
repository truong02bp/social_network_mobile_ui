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
    media: json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
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
      'media': instance.media?.toJson(),
      'interactions': instance.interactions?.map((e) => e.toJson()).toList(),
    };
