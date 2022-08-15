import 'package:json_annotation/json_annotation.dart';

part 'user_authorization_response.g.dart';

@JsonSerializable()
class UserAuthorizationResponse {
  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'user_uid')
  String user_uid;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'email_id')
  String email_id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'about_me')
  String about_me;

  @JsonKey(name: 'profile_picture')
  String? profile_picture;

  UserAuthorizationResponse({
    required this.token,
    required this.user_uid,
    required this.username,
    required this.email_id,
    required this.name,
    required this.about_me,
    required this.profile_picture,
  });

  factory UserAuthorizationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAuthorizationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserAuthorizationResponseToJson(this);
}
