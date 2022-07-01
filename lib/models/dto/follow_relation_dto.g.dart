// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_relation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowRelationDto _$FollowRelationDtoFromJson(Map<String, dynamic> json) {
  return FollowRelationDto(
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    isFollowing: json['isFollowing'] as bool,
  );
}

Map<String, dynamic> _$FollowRelationDtoToJson(FollowRelationDto instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'isFollowing': instance.isFollowing,
    };
