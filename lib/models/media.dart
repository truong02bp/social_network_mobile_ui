
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';
@JsonSerializable()
class Media {
  int id;
  String contentType;
  String name;
  String url;

  Media({required this.id, required this.contentType, required this.name, required this.url});

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}