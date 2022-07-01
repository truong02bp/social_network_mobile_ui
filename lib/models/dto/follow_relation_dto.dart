import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_mobile_ui/models/user.dart';

part 'follow_relation_dto.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class FollowRelationDto {
  User user;
  bool isFollowing;

  FollowRelationDto({required this.user, required this.isFollowing});

  factory FollowRelationDto.fromJson(Map<String, dynamic> json) =>
      _$FollowRelationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FollowRelationDtoToJson(this);
}
