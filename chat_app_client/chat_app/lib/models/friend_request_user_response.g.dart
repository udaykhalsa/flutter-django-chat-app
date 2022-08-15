// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequestUser _$FriendRequestUserFromJson(Map<String, dynamic> json) =>
    FriendRequestUser(
      requestId: json['id'] as int?,
      userUid: json['sender__user_uid'] as String?,
      username: json['sender__username'] as String?,
      avatar: json['sender__profile_picture'] as String?,
      name: json['sender__name'] as String?,
      aboutMe: json['sender__about_me'] as String?,
    );

Map<String, dynamic> _$FriendRequestUserToJson(FriendRequestUser instance) =>
    <String, dynamic>{
      'id': instance.requestId,
      'sender__user_uid': instance.userUid,
      'sender__username': instance.username,
      'sender__profile_picture': instance.avatar,
      'sender__name': instance.name,
      'sender__about_me': instance.aboutMe,
    };
