import 'package:json_annotation/json_annotation.dart';
import 'chat_messages_list_response.dart';

part 'chat_messages_response.g.dart';

@JsonSerializable()
class ChatMessagesResponse {
  @JsonKey(name: 'data')
  List<ChatMessagesListResponse> chatMessagesListResponse;

  ChatMessagesResponse({required this.chatMessagesListResponse});

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessagesResponseToJson(this);
}
