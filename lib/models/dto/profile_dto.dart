import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable(explicitToJson: true, )
class ProfileDto {
  int posts;
  int followers;
  int following;

  ProfileDto({required this.posts, required this.followers, required this.following});

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}