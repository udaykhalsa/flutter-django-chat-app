import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:international_chat_app/configuration/conf.dart';
import 'package:international_chat_app/screens/intro_screen.dart';

import '../configuration/authorization_storage.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  HttpService http = HttpService();
  StorageServices storage = StorageServices();

  var isLoading = false;

  Future logoutUser() async {
    Response response;
    response = await http.logoutUser('api/v1/logout/');
    storage.logoutUserStorage();
  }

  Future<Map> getUserInfo() async {
    var userStoredData = storage.getUserInfoStorage();
    Map userData = await userStoredData;
    return userData;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map userData = snapshot.data as Map;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  AppBar(
                    toolbarHeight: 75.0,
                  ),
                  Container(
                    height: 180.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://i.pinimg.com/originals/e0/41/fa/e041fa5038a055ff62d51fdbcc15dbc9.jpg'))),
                  ),
                  Text(
                    userData['name'] as String,
                    style: const TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    '@${userData['username']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 12.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Text(
                        userData['about_me'],
                        style: const TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      logoutUser();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AppIntroHome(),
                              maintainState: true),
                          (Route<dynamic> route) => false);
                      sleep(const Duration(seconds: 1));
                    },
                    label: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                      ),
                    ),
                    icon: Icon(
                      Iconsax.logout_1,
                      color: Colors.red[700],
                    ),
                    style: TextButton.styleFrom(
                      fixedSize: const Size(150.0, 40.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                        // side: const BorderSide(color: Colors.black12),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2.0,
                    endIndent: 130.0,
                    indent: 130.0,
                    color: Color.fromRGBO(245, 117, 106, 1),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
