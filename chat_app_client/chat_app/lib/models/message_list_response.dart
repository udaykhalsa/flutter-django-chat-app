import 'package:json_annotation/json_annotation.dart';
import 'message_list_data_response.dart';

part 'message_list_response.g.dart';

@JsonSerializable()
class MessagesListResponse {
  MessagesListResponse({required this.messagesListDataResponse});

  @JsonKey(name: 'data')
  List<MessageListDataResponse> messagesListDataResponse;

  factory MessagesListResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessagesListResponseToJson(this);
}
