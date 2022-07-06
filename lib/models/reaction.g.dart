// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map<String, dynamic> json) {
  return Reaction(
    code: json['code'] as String,
    name: json['name'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'id': instance.id,
    };
