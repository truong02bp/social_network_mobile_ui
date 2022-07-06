import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_mobile_ui/models/media.dart';
import 'package:social_network_mobile_ui/models/message.dart';
import 'package:social_network_mobile_ui/models/messenger.dart';

part 'conversation.g.dart';

@JsonSerializable(explicitToJson: true)
class Conversation {
  int id;
  String? name;
  String? color;
  bool isGroup;
  Media? media;
  Messenger user;
  List<Messenger> guests;
  Message? lastMessage;

  Conversation(
      {this.name,
      this.color,
      required this.isGroup,
      required this.id,
      this.media,
      required this.user,
      required this.guests,
      this.lastMessage});

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
