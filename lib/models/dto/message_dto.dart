import 'package:json_annotation/json_annotation.dart';

part 'message_dto.g.dart';

enum MessageType { TEXT, IMAGE, VIDEO }

@JsonSerializable(
  explicitToJson: true,
)
class MessageDto {
  final String? content;
  final int messengerId;
  final String? reaction;
  final MessageType? type;

  MessageDto(
      {this.content, required this.messengerId, this.type, this.reaction});

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
