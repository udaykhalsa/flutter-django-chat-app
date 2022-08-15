// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesListResponse _$MessagesListResponseFromJson(
        Map<String, dynamic> json) =>
    MessagesListResponse(
      messagesListDataResponse: (json['data'] as List<dynamic>)
          .map((e) =>
              MessageListDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessagesListResponseToJson(
        MessagesListResponse instance) =>
    <String, dynamic>{
      'data': instance.messagesListDataResponse,
    };
