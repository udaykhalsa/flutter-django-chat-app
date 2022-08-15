import 'package:json_annotation/json_annotation.dart';
import 'friend_response.dart';

part 'friends_list_response.g.dart';


@JsonSerializable()
class FriendListResponse {
  FriendListResponse({
    required this.friendUser
  });

  @JsonKey(name: 'data')
  List<FriendUserResponse> friendUser;

  
  factory FriendListResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FriendListResponseToJson(this);
}