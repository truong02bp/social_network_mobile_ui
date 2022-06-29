import 'package:json_annotation/json_annotation.dart';

part 'media_dto.g.dart';

@JsonSerializable(explicitToJson: true, )
class MediaDto {
  String name;
  String? contentType;
  String? url;
  String? bytes;
  int? userId;

  MediaDto({required this.name, this.contentType, this.url, this.bytes, this.userId});

  factory MediaDto.fromJson(Map<String, dynamic> json) => _$MediaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDtoToJson(this);
}