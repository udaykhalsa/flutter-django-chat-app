import 'package:json_annotation/json_annotation.dart';

part 'message_list_data_response.g.dart';

@JsonSerializable()
class MessageListDataResponse {
  @JsonKey(name: 'user__username')
  String? userUsername;

  @JsonKey(name: 'user__user_uid')
  String? userUserUid;

  @JsonKey(name: 'room__id')
  int? roomId;

  @JsonKey(name: 'room__name')
  String? roomName;

  @JsonKey(name: 'room__last_message')
  String? roomLastMessage;
  
  @JsonKey(name: 'room__last_sent_user')
  String? roomLastSentUser;
  
  MessageListDataResponse({
    required this.userUsername,
    required this.userUserUid,
    required this.roomId,
    required this.roomName,
    required this.roomLastMessage,
    required this.roomLastSentUser,
  });

  factory MessageListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageListDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageListDataResponseToJson(this);
}
