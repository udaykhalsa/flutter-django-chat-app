// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendListResponse _$FriendListResponseFromJson(Map<String, dynamic> json) =>
    FriendListResponse(
      friendUser: (json['data'] as List<dynamic>)
          .map((e) => FriendUserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendListResponseToJson(FriendListResponse instance) =>
    <String, dynamic>{
      'data': instance.friendUser,
    };
