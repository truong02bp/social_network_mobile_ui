// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageMedia _$MessageMediaFromJson(Map<String, dynamic> json) {
  return MessageMedia(
    id: json['id'] as int,
    contentType: json['contentType'] as String,
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$MessageMediaToJson(MessageMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contentType': instance.contentType,
      'name': instance.name,
      'url': instance.url,
    };
