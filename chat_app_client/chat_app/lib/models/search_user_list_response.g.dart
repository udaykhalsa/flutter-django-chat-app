// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUserListResponse _$SearchUserListResponseFromJson(
        Map<String, dynamic> json) =>
    SearchUserListResponse(
      searchUser: (json['data'] as List<dynamic>)
          .map((e) => SearchUserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchUserListResponseToJson(
        SearchUserListResponse instance) =>
    <String, dynamic>{
      'data': instance.searchUser,
    };
