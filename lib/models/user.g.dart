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
    phone: json['phone'] as String,
    address: json['address'] as String?,
    online: json['online'] as bool,
    lateOnline: json['lateOnline'] == null
        ? null
        : DateTime.parse(json['lateOnline'] as String),
    avatar: Media.fromJson(json['avatar'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'online': instance.online,
      'lateOnline': instance.lateOnline?.toIso8601String(),
      'avatar': instance.avatar,
    };
