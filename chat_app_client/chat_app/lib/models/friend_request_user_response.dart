import 'package:json_annotation/json_annotation.dart';

part 'friend_request_user_response.g.dart';

@JsonSerializable()
class FriendRequestUser {
  @JsonKey(name: 'id')
  int? requestId;

  @JsonKey(name: 'sender__user_uid')
  String? userUid;

  @JsonKey(name: 'sender__username')
  String? username;

  @JsonKey(name: 'sender__profile_picture')
  String? avatar;

  @JsonKey(name: 'sender__name')
  String? name;

  @JsonKey(name: 'sender__about_me')
  String? aboutMe;

  FriendRequestUser({
    required this.requestId,
    required this.userUid,
    required this.username,
    required this.avatar,
    required this.name,
    required this.aboutMe,
  });

  factory FriendRequestUser.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestUserFromJson(json);
  Map<String, dynamic> toJson() => _$FriendRequestUserToJson(this);
}
