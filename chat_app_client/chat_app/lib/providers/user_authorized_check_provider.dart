import '../configuration/authorization_storage.dart';

class UserAuthorizedCheckProvider {
  StorageServices storage = StorageServices();
  String userToken = '';

  Future<String> getUserInfo() async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    if (storedData['token'] != null) {
      userToken = storedData['token'];
    } else {
      userToken = '';
    }
    return userToken;
  }
}
