import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../configuration/conf.dart';
import '../configuration/authorization_storage.dart';
import '../models/user_authorization_response.dart';

bool isLoading = false;
HttpService http = HttpService();
StorageServices storage = StorageServices();
Map storedData = {};

class UserLoginProvider with ChangeNotifier {
  String loginMessage = '';
  late UserAuthorizationResponse userRegistrationResponse;

  Future loginUser(userData) async {
    Response response;

    try {
      isLoading = true;
      response = await http.loginUser('api/v1/login/', userData);
      isLoading = false;

      if (response.statusCode == 200) {
        var newReponse = response.data;
        userRegistrationResponse =
            UserAuthorizationResponse.fromJson(newReponse['data']);
        loginMessage = newReponse['message'];

        userData = {
          'token': userRegistrationResponse.token,
          'user_id': userRegistrationResponse.user_uid,
          'username': userRegistrationResponse.username,
          'email_id': userRegistrationResponse.email_id,
          'name': userRegistrationResponse.name,
          'about_me': userRegistrationResponse.about_me,
          'profile_picture': userRegistrationResponse.profile_picture
        };

        storage.writeRegisterUserDataStorage(userData);
      } else {
        print('status code is not 200.');
      }
    } on Exception catch (e) {
      isLoading = false;
      loginMessage = e.toString().substring(11);
    }
    notifyListeners();
  }
}

class UserRegistrationProvider with ChangeNotifier {
  String loginMessage = '';
  late UserAuthorizationResponse userRegistrationResponse;

  Future registerUser(userData) async {
    Response response;

    try {
      isLoading = true;
      response = await http.registerUser('api/v1/signup/', userData);
      isLoading = false;

      if (response.statusCode == 201) {
        var newReponse = response.data;
        userRegistrationResponse =
            UserAuthorizationResponse.fromJson(newReponse['data']);
        loginMessage = newReponse['message'];

        userData = {
          'token': userRegistrationResponse.token,
          'username': userRegistrationResponse.username,
          'email_id': userRegistrationResponse.email_id,
          'name': userRegistrationResponse.name,
          'about_me': userRegistrationResponse.about_me,
          'profile_picture': userRegistrationResponse.profile_picture
        };

        storage.writeRegisterUserDataStorage(userData);
      } else {
        print('status code is not 200.');
      }
    } on Exception catch (e) {
      isLoading = false;
      loginMessage = e.toString().substring(11);
    }
    notifyListeners();
  }
}
