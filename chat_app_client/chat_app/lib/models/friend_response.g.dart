// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendUserResponse _$FriendUserResponseFromJson(Map<String, dynamic> json) =>
    FriendUserResponse(
      user_uid: json['user_uid'] as String?,
      username: json['username'] as String?,
      profile_picture: json['profile_picture'] as String?,
      name: json['name'] as String?,
      about_me: json['about_me'] as String?,
    );

Map<String, dynamic> _$FriendUserResponseToJson(FriendUserResponse instance) =>
    <String, dynamic>{
      'user_uid': instance.user_uid,
      'username': instance.username,
      'profile_picture': instance.profile_picture,
      'name': instance.name,
      'about_me': instance.about_me,
    };
