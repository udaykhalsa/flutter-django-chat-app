import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../configuration/conf.dart';
import '../models/friend_request_list_response.dart';
import '../models/friend_request_user_response.dart';
import '../models/friend_response.dart';
import '../models/friends_list_response.dart';

class FriendsProvider with ChangeNotifier {
  bool isLoading = false;

  HttpService http = HttpService();

  late FriendRequestList friendRequestListResponse;
  List<FriendRequestUser> friendRequestUsers = [];

  late FriendListResponse friendListResponse;
  List<FriendUserResponse> friendUsers = [];

  Future getFriends() async {
    Response response;

    try {
      isLoading = true;

      response = await http.getFriendListRequest('api/v1/friend-list/');

      isLoading = false;

      if (response.statusCode == 200) {
        friendListResponse = FriendListResponse.fromJson(response.data);
        friendUsers = friendListResponse.friendUser;

        notifyListeners();
      } else {
        print('Status code is not 200.');
      }
    } on Exception catch (_) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future getFriendRequests() async {
    Response response;

    try {
      isLoading = true;

      response =
          await http.getFriendRequestListRequest('api/v1/friend-request-list/');

      isLoading = false;

      if (response.statusCode == 200) {
        friendRequestListResponse = FriendRequestList.fromJson(response.data);
        friendRequestUsers = friendRequestListResponse.friendRequestUser;
        notifyListeners();
      } else {
        print('Status code is not 200.');
      }
    } on Exception catch (_) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> friendRequestAction(int requestID, String action) async {
    Response response;

    try {
      isLoading = true;

      response =
          await http.friendRequestActionRequest('api/v1/friend_request_action/', requestID, action);

      isLoading = false;

      if (response.statusCode == 200) {
        friendRequestListResponse = FriendRequestList.fromJson(response.data);
        friendRequestUsers = friendRequestListResponse.friendRequestUser;
        notifyListeners();
      } else {
        print('Status code is not 200.');
      }
    } on Exception catch (_) {
      isLoading = false;
      notifyListeners();
    }
  }
}
