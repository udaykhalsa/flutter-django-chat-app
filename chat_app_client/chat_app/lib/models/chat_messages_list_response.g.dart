// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessagesListResponse _$ChatMessagesListResponseFromJson(
        Map<String, dynamic> json) =>
    ChatMessagesListResponse(
      messageId: json['id'] as int?,
      roomId: json['room'] as int?,
      fromMessageUser: json['user'] as String?,
      messageContent: json['content'] as String?,
      messageTime: json['created_at'] as String?,
    );

Map<String, dynamic> _$ChatMessagesListResponseToJson(
        ChatMessagesListResponse instance) =>
    <String, dynamic>{
      'id': instance.messageId,
      'room': instance.roomId,
      'user': instance.fromMessageUser,
      'content': instance.messageContent,
      'created_at': instance.messageTime,
    };
