import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_mobile_ui/models/dto/message_dto.dart';
import 'package:social_network_mobile_ui/models/message_interaction.dart';
import 'package:social_network_mobile_ui/models/message_media.dart';
import 'package:social_network_mobile_ui/models/messenger.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  int id;
  DateTime createdDate;
  String? content;
  Messenger sender;
  MessageType type;
  List<MessageMedia>? medias;
  List<MessageInteraction>? interactions;

  Message(
      {this.content,
      required this.sender,
      required this.id,
      required this.createdDate,
      required this.type,
      this.medias,
      this.interactions});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
