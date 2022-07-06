import 'package:json_annotation/json_annotation.dart';

part 'reaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Reaction {
  String code;
  String name;
  int id;

  Reaction({required this.code, required this.name, required this.id});

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionToJson(this);
}
