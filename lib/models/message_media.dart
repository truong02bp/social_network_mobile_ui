import 'package:json_annotation/json_annotation.dart';
import 'package:social_network_mobile_ui/models/media.dart';

part 'message_media.g.dart';

@JsonSerializable()
class MessageMedia extends Media {
  MessageMedia(
      {required int id,
      required String contentType,
      required String name,
      required String url})
      : super(id: id, contentType: contentType, name: name, url: url);

  factory MessageMedia.fromJson(Map<String, dynamic> json) =>
      _$MessageMediaFromJson(json);

  Map<String, dynamic> toJson() => _$MessageMediaToJson(this);
}
