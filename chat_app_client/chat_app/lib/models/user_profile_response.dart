import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  @JsonKey(name: 'user_uid')
  String userUid;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'about_me')
  String aboutMe;

  @JsonKey(name: 'profile_picture')
  String? profilePicture;

  @JsonKey(name: 'is_friend')
  bool isFriend;

  @JsonKey(name: 'sender')
  bool sender;

  @JsonKey(name: 'receiver')
  bool receiver;

  UserProfileResponse(
      {required this.userUid,
      required this.username,
      required this.name,
      required this.aboutMe,
      required this.profilePicture,
      required this.isFriend,
      required this.sender,
      required this.receiver});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
