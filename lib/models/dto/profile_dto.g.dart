// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) {
  return ProfileDto(
    posts: json['posts'] as int,
    followers: json['followers'] as int,
    following: json['following'] as int,
  );
}

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'followers': instance.followers,
      'following': instance.following,
    };
