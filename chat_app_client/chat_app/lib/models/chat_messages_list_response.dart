import 'package:json_annotation/json_annotation.dart';

part 'chat_messages_list_response.g.dart';

@JsonSerializable()
class ChatMessagesListResponse {
  @JsonKey(name: 'id')
  int? messageId;

  @JsonKey(name: 'room')
  int? roomId;

  @JsonKey(name: 'user')
  String? fromMessageUser;

  @JsonKey(name: 'content')
  String? messageContent;

  @JsonKey(name: 'created_at')
  String? messageTime;

  ChatMessagesListResponse({
    required this.messageId,
    required this.roomId,
    required this.fromMessageUser,
    required this.messageContent,
    required this.messageTime,
  });

  factory ChatMessagesListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessagesListResponseToJson(this);
}
