// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserResponse _$SearchUserResponseFromJson(Map<String, dynamic> json) =>
    SearchUserResponse(
      user_uid: json['user_uid'] as String?,
      username: json['username'] as String?,
      profile_picture: json['profile_picture'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SearchUserResponseToJson(SearchUserResponse instance) =>
    <String, dynamic>{
      'user_uid': instance.user_uid,
      'username': instance.username,
      'profile_picture': instance.profile_picture,
      'name': instance.name,
    };
