import 'package:json_annotation/json_annotation.dart';
part 'authentication_request.g.dart';

@JsonSerializable(explicitToJson: true, )
class AuthenticationRequest {
  String email;
  String password;

  AuthenticationRequest({required this.email, required this.password});

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) => _$AuthenticationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationRequestToJson(this);

}