import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_mobile_ui/models/media.dart';
import 'package:social_network_mobile_ui/models/message_interaction.dart';
import 'package:social_network_mobile_ui/models/messenger.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  int id;
  DateTime createdDate;
  String? content;
  Messenger sender;
  Media? media;
  List<MessageInteraction>? messageInteractions;

  Message(
      {this.content,
      required this.sender,
      required this.id,
      required this.createdDate,
      this.media,
      this.messageInteractions});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
