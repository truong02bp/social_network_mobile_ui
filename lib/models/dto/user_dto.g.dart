// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return UserDto(
    id: json['id'] as int,
    oldPassword: json['oldPassword'] as String,
    newPassword: json['newPassword'] as String,
  );
}

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
