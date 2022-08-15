import 'package:json_annotation/json_annotation.dart';

part 'search_user_response.g.dart';

@JsonSerializable()
class SearchUserResponse {
  @JsonKey(name: 'user_uid')
  String? user_uid;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'profile_picture')
  String? profile_picture;

  @JsonKey(name: 'name')
  String? name;


  SearchUserResponse({
    required this.user_uid,
    required this.username,
    required this.profile_picture,
    required this.name,
  });

  factory SearchUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchUserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchUserResponseToJson(this);
}