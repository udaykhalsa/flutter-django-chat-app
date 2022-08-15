import 'package:json_annotation/json_annotation.dart';
import 'search_user_response.dart';

part 'search_user_list_response.g.dart';


@JsonSerializable()
class SearchUserListResponse {
  SearchUserListResponse({
    required this.searchUser
  });

  @JsonKey(name: 'data')
  List<SearchUserResponse> searchUser;

  
  factory SearchUserListResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchUserListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchUserListResponseToJson(this);
}