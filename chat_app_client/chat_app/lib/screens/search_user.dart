import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../configuration/conf.dart';
import '../models/search_user_list_response.dart';
import '../models/search_user_response.dart';
import 'user_profile_screen.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  bool isLoading = false;
  HttpService http = HttpService();
  TextEditingController searchUserController = TextEditingController();

  late SearchUserListResponse searchUserListResponse;
  List<SearchUserResponse> searchUserResponse = [];

  Future getSearchedUsers(username) async {
    Response response;

    try {
      isLoading = true;

      response =
          await http.getSearchedUsersRequest('api/v1/search-user/$username');

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          searchUserListResponse =
              SearchUserListResponse.fromJson(response.data);
          searchUserResponse = searchUserListResponse.searchUser;
        });
        print(searchUserResponse);
        return true;
      } else {
        return true;
      }
    } on Exception catch (_) {
      isLoading = false;
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        titleSpacing: 0,
        title: TextField(
          controller: searchUserController,
          autofocus: true,
          autocorrect: true,
          enableSuggestions: false,
          textInputAction: TextInputAction.go,
          onSubmitted: (value) {
            getSearchedUsers(value);
          },
          maxLines: null,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Search User',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            focusColor: Colors.black,
            onPressed: () {
              String username = searchUserController.text;
              getSearchedUsers(username);
            },
            icon: const Icon(Iconsax.user_search),
          ),
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10.0),
            itemCount: searchUserResponse.length,
            itemBuilder: (context, index) {
              final searchUser = searchUserResponse[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => UserProfile(
                        userUid: searchUser.user_uid as String,
                      ),
                    ),
                  );
                },
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/e0/41/fa/e041fa5038a055ff62d51fdbcc15dbc9.jpg'),
                  radius: 30.0,
                ),
                title: Text(
                  // 'dadas',
                  searchUser.username as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                isThreeLine: false,
              );
            },
          );
        },
      ),
    );
  }
}
