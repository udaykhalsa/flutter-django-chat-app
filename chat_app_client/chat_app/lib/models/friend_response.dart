import 'package:json_annotation/json_annotation.dart';

part 'friend_response.g.dart';

@JsonSerializable()
class FriendUserResponse {
  @JsonKey(name: 'user_uid')
  String? user_uid;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'profile_picture')
  String? profile_picture;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'about_me')
  String? about_me;

  FriendUserResponse({
    required this.user_uid,
    required this.username,
    required this.profile_picture,
    required this.name,
    required this.about_me,
  });

  factory FriendUserResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FriendUserResponseToJson(this);
}