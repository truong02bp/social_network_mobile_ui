// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageInteraction _$MessageInteractionFromJson(Map<String, dynamic> json) {
  return MessageInteraction(
    id: json['id'] as int,
    seenBy: Messenger.fromJson(json['seenBy'] as Map<String, dynamic>),
    reaction: json['reaction'] == null
        ? null
        : Reaction.fromJson(json['reaction'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MessageInteractionToJson(MessageInteraction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seenBy': instance.seenBy.toJson(),
      'reaction': instance.reaction?.toJson(),
    };
