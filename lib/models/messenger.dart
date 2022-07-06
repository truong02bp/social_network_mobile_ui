import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_mobile_ui/models/user.dart';

part 'messenger.g.dart';

@JsonSerializable(explicitToJson: true)
class Messenger {
  int id;
  String? nickName;
  int conversationId;
  User user;

  Messenger(
      {required this.id,
      this.nickName,
      required this.conversationId,
      required this.user});

  factory Messenger.fromJson(Map<String, dynamic> json) =>
      _$MessengerFromJson(json);

  Map<String, dynamic> toJson() => _$MessengerToJson(this);
}
