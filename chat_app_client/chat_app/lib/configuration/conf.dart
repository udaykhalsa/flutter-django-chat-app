import 'package:dio/dio.dart';
import 'package:international_chat_app/configuration/authorization_storage.dart';

class HttpService {
  final Dio _dio = Dio();
  final StorageServices storage = StorageServices();

  String userToken = 'none';

  final baseUrl = 'http://10.0.2.2:8000/';

  Future<Response> registerUser(String endPoint, userData) async {
    late var header = {
      'content-type': 'application/json',
    };
    Response response;

    String username = userData['username'];
    String emailId = userData['email_id'];
    String name = userData['name'];
    String password = userData['password'];
    String confirmPassword = userData['confirm_password'];

    var data = {
      'username': username,
      'email_id': emailId,
      'name': name,
      'password': password,
      'confirm_password': confirmPassword
    };

    try {
      response = await _dio.post(
        baseUrl + endPoint,
        data: data,
        options: Options(
          headers: header,
        ),
      );
    } on DioError catch (e) {
      var responseMessage = e.response?.data;
      try {
        responseMessage = responseMessage['message']['non_field_errors'][0];
      } on Exception catch (_) {
        responseMessage = responseMessage['message']['message'][0];
      }

      throw Exception(responseMessage);
    }
    return response;
  }

  Future<Response> loginUser(String endPoint, userData) async {
    late var header = {
      'content-type': 'application/json',
    };
    Response response;

    String username = userData['username'];
    String password = userData['password'];

    var data = {
      'username': username,
      'password': password,
    };

    try {
      response = await _dio.post(baseUrl + endPoint,
          data: data,
          options: Options(
            headers: header,
          ));
    } on DioError catch (e) {
      var responseMessage = e.response?.data;
      responseMessage = responseMessage['message']['message'][0];
      throw Exception(responseMessage);
    }
    return response;
  }

  Future<Response> logoutUser(String endPoint) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    Response response;

    try {
      response = await _dio.get(baseUrl + endPoint,
          options: Options(
            headers: header,
          ));
    } on DioError catch (e) {
      var responseMessage = e.response;
      throw Exception(responseMessage);
    }
    return response;
  }

  Future<Response> getNearbyUserProfileRequest(String userUid) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    Response response;

    try {
      response = await _dio.get('${baseUrl}api/v1/user-profile-info/$userUid/',
          options: Options(headers: header));
    } on DioError catch (e) {
      throw Exception(e.response);
    }
    return response;
  }

  Future<Response> getFriendRequestListRequest(String endPoint) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    Response response;

    try {
      response = await _dio.get(
        baseUrl + endPoint,
        options: Options(headers: header),
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> getFriendListRequest(String endPoint) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    Response response;

    try {
      response = await _dio.get(
        baseUrl + endPoint,
        options: Options(headers: header),
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> getSearchedUsersRequest(String endPoint) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    Response response;

    try {
      response = await _dio.get(
        baseUrl + endPoint,
        options: Options(headers: header),
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> getChatRoomsResponse(String endPoint) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    Response response;

    try {
      response = await _dio.get(
        baseUrl + endPoint,
        options: Options(headers: header),
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> sendFriendRequest(String endPoint, String userUid) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    var data = {
      'sender_user': 'eecd66e7-4874-4b96-bde0-7dd37d0b83b3',
      'receiver_user': userUid
    };
    Response response;

    try {
      response = await _dio.post(baseUrl + endPoint,
          options: Options(headers: header), data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> friendRequestActionRequest(
      String endPoint, int requestID, String action) async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    userToken = storedData['token'];

    late var header = {
      'content-type': 'application/json',
      'Authorization': 'Token $userToken',
    };

    var data = {'request_id': requestID, 'request_option': action};

    Response response;

    try {
      response = await _dio.post(baseUrl + endPoint,
          options: Options(headers: header), data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return response;
  }
}
