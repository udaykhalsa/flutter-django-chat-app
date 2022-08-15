import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

import '../configuration/conf.dart';
import '../models/user_profile_response.dart';

class UserProfileProvider with ChangeNotifier {
  bool isLoading = false;
  HttpService http = HttpService();
  late UserProfileResponse userProfileResponse;

  Future<Response> getUserProfileData(userUid) async {
    Response response;

    try {
      isLoading = true;
      response = await http.getNearbyUserProfileRequest(userUid);

      var newResponse = response.data;
      userProfileResponse =
          UserProfileResponse.fromJson(newResponse['data']);
      isLoading = false;
      return response;
    } on Exception catch (_) {
      isLoading = false;
      throw Exception('Exception');
    }
  }

  Future<Response> sendFriendRequest(userUid) async {
    Response response;

    try {
      isLoading = true;
      response = await http.getNearbyUserProfileRequest(userUid);

      var newResponse = response.data;
      userProfileResponse =
          UserProfileResponse.fromJson(newResponse['data']);
      isLoading = false;
      return response;
    } on Exception catch (_) {
      isLoading = false;
      throw Exception('Exception');
    }
  }
}
