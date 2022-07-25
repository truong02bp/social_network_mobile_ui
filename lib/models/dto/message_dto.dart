import 'package:json_annotation/json_annotation.dart';

part 'message_dto.g.dart';

enum MessageType { TEXT, MEDIA }

@JsonSerializable(
  explicitToJson: true,
)
class MessageDto {
  final String? content;
  final int messengerId;
  final int? messageId;
  String? reaction;
  final MessageType? type;
  final List<int>? messageMediaIds;

  MessageDto(
      {this.content,
      required this.messengerId,
      this.type,
      this.reaction,
      this.messageMediaIds,
      this.messageId});

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
