import 'package:social_network_mobile_ui/models/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String email;
  String name;
  String phone;
  String? address;
  bool online;
  DateTime? lateOnline;
  Media avatar;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      this.address,
      required this.online,
      this.lateOnline,
      required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
