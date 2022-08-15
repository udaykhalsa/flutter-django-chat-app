// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      userUid: json['user_uid'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      aboutMe: json['about_me'] as String,
      profilePicture: json['profile_picture'] as String?,
      isFriend: json['is_friend'] as bool,
      sender: json['sender'] as bool,
      receiver: json['receiver'] as bool,
    );

Map<String, dynamic> _$UserProfileResponseToJson(
        UserProfileResponse instance) =>
    <String, dynamic>{
      'user_uid': instance.userUid,
      'username': instance.username,
      'name': instance.name,
      'about_me': instance.aboutMe,
      'profile_picture': instance.profilePicture,
      'is_friend': instance.isFriend,
      'sender': instance.sender,
      'receiver': instance.receiver,
    };
