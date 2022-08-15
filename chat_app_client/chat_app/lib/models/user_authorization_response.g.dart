// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_authorization_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthorizationResponse _$UserAuthorizationResponseFromJson(
        Map<String, dynamic> json) =>
    UserAuthorizationResponse(
      token: json['token'] as String,
      user_uid: json['user_uid'] as String,
      username: json['username'] as String,
      email_id: json['email_id'] as String,
      name: json['name'] as String,
      about_me: json['about_me'] as String,
      profile_picture: json['profile_picture'] as String?,
    );

Map<String, dynamic> _$UserAuthorizationResponseToJson(
        UserAuthorizationResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user_uid': instance.user_uid,
      'username': instance.username,
      'email_id': instance.email_id,
      'name': instance.name,
      'about_me': instance.about_me,
      'profile_picture': instance.profile_picture,
    };
