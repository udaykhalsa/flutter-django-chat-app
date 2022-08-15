import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageServices {
  final storage = const FlutterSecureStorage();

  Future<void> writeRegisterUserDataStorage(userData) async {
    await storage.write(key: 'token', value: userData['token']);
    await storage.write(key: 'user_id', value: userData['user_id']);
    await storage.write(key: 'username', value: userData['username']);
    await storage.write(key: 'email_id', value: userData['email_id']);
    await storage.write(key: 'name', value: userData['name']);
    await storage.write(key: 'about_me', value: userData['about_me']);
    await storage.write(
        key: 'profile_picture', value: userData['profile_picture']);
  }

  Future<Map> getUserInfoStorage() async {
    String? token = await storage.read(key: 'token');
    String? user_id = await storage.read(key: 'user_id');
    String? username = await storage.read(key: 'username');
    String? emailId = await storage.read(key: 'email_id');
    String? name = await storage.read(key: 'name');
    String? aboutMe = await storage.read(key: 'about_me');
    String? profilePicture = await storage.read(key: 'profile_picture');

    var userData = {
      'token': token,
      'user_id': user_id,
      'username': username,
      'email_id': emailId,
      'name': name,
      'about_me': aboutMe,
      'profile_picture': profilePicture,
    };

    return userData;
  }

  Future<bool> logoutUserStorage() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'username');
    await storage.delete(key: 'email_id');
    await storage.delete(key: 'name');
    await storage.delete(key: 'about_me');
    await storage.delete(key: 'profile_picture');

    return true;
  }
}
