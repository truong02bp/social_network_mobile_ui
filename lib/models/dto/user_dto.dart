import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class UserDto {
  int id;
  String oldPassword;
  String newPassword;

  UserDto(
      {required this.id, required this.oldPassword, required this.newPassword});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
