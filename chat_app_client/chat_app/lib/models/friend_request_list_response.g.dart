// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequestList _$FriendRequestListFromJson(Map<String, dynamic> json) =>
    FriendRequestList(
      friendRequestUser: (json['data'] as List<dynamic>)
          .map((e) => FriendRequestUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendRequestListToJson(FriendRequestList instance) =>
    <String, dynamic>{
      'data': instance.friendRequestUser,
    };
