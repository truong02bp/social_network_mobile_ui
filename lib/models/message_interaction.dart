import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_mobile_ui/models/messenger.dart';
import 'package:social_network_mobile_ui/models/reaction.dart';

part 'message_interaction.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageInteraction {
  int id;
  Messenger seenBy;
  Reaction? reaction;

  MessageInteraction({required this.id, required this.seenBy, this.reaction});

  factory MessageInteraction.fromJson(Map<String, dynamic> json) =>
      _$MessageInteractionFromJson(json);

  Map<String, dynamic> toJson() => _$MessageInteractionToJson(this);
}
