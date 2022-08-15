import 'package:json_annotation/json_annotation.dart';
import 'friend_request_user_response.dart';

part 'friend_request_list_response.g.dart';


@JsonSerializable()
class FriendRequestList {
  FriendRequestList({
    required this.friendRequestUser
  });

  @JsonKey(name: 'data')
  List<FriendRequestUser> friendRequestUser;

  
  factory FriendRequestList.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestListFromJson(json);
  Map<String, dynamic> toJson() => _$FriendRequestListToJson(this);
}