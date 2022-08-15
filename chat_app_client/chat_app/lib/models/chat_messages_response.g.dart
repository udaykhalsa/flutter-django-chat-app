// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessagesResponse _$ChatMessagesResponseFromJson(
        Map<String, dynamic> json) =>
    ChatMessagesResponse(
      chatMessagesListResponse: (json['data'] as List<dynamic>)
          .map((e) =>
              ChatMessagesListResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMessagesResponseToJson(
        ChatMessagesResponse instance) =>
    <String, dynamic>{
      'data': instance.chatMessagesListResponse,
    };
