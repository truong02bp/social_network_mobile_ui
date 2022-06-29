// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    email: json['email'] as String,
    name: json['name'] as String,
    username: json['username'] as String,
    phone: json['phone'] as String,
    address: json['address'] as String?,
    isOnline: json['isOnline'] as bool,
    isPrivate: json['isPrivate'] as bool,
    lastOnline: json['lastOnline'] == null
        ? null
        : DateTime.parse(json['lastOnline'] as String),
    avatar: Media.fromJson(json['avatar'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'phone': instance.phone,
      'address': instance.address,
      'isOnline': instance.isOnline,
      'isPrivate': instance.isPrivate,
      'lastOnline': instance.lastOnline?.toIso8601String(),
      'avatar': instance.avatar.toJson(),
    };
