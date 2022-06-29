// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaDto _$MediaDtoFromJson(Map<String, dynamic> json) {
  return MediaDto(
    name: json['name'] as String,
    contentType: json['contentType'] as String?,
    url: json['url'] as String?,
    bytes: json['bytes'] as String?,
    userId: json['userId'] as int?,
  );
}

Map<String, dynamic> _$MediaDtoToJson(MediaDto instance) => <String, dynamic>{
      'name': instance.name,
      'contentType': instance.contentType,
      'url': instance.url,
      'bytes': instance.bytes,
      'userId': instance.userId,
    };
