// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
    name: json['name'] as String?,
    color: json['color'] as String?,
    isGroup: json['isGroup'] as bool,
    id: json['id'] as int,
    media: json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
    user: Messenger.fromJson(json['user'] as Map<String, dynamic>),
    guests: (json['guests'] as List<dynamic>)
        .map((e) => Messenger.fromJson(e as Map<String, dynamic>))
        .toList(),
    lastMessage: json['lastMessage'] == null
        ? null
        : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'isGroup': instance.isGroup,
      'media': instance.media?.toJson(),
      'user': instance.user.toJson(),
      'guests': instance.guests.map((e) => e.toJson()).toList(),
      'lastMessage': instance.lastMessage?.toJson(),
    };
