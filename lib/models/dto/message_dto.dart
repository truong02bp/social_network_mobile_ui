import 'package:json_annotation/json_annotation.dart';

part 'message_dto.g.dart';

enum MessageType { TEXT, IMAGE, VIDEO }

@JsonSerializable(
  explicitToJson: true,
)
class MessageDto {
  final String content;
  final int messengerId;
  final MessageType type;

  MessageDto(
      {required this.content, required this.messengerId, required this.type});

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}
