// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageListDataResponse _$MessageListDataResponseFromJson(
        Map<String, dynamic> json) =>
    MessageListDataResponse(
      userUsername: json['user__username'] as String?,
      userUserUid: json['user__user_uid'] as String?,
      roomId: json['room__id'] as int?,
      roomName: json['room__name'] as String?,
      roomLastMessage: json['room__last_message'] as String?,
      roomLastSentUser: json['room__last_sent_user'] as String?,
    );

Map<String, dynamic> _$MessageListDataResponseToJson(
        MessageListDataResponse instance) =>
    <String, dynamic>{
      'user__username': instance.userUsername,
      'user__user_uid': instance.userUserUid,
      'room__id': instance.roomId,
      'room__name': instance.roomName,
      'room__last_message': instance.roomLastMessage,
      'room__last_sent_user': instance.roomLastSentUser,
    };
