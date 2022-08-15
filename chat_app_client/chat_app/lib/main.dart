import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_profile_provider.dart';
import 'screens/homepage.dart';
import 'screens/intro_screen.dart';

import 'providers/user_authorized_check_provider.dart';
import 'providers/friend_list_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userAuthorizedCheck = UserAuthorizedCheckProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FriendsProvider>(
          create: (context) => FriendsProvider(),
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) => UserProfileProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
                elevation: 0,
                color: Colors.transparent,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                actionsIconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold)),
            backgroundColor: Colors.grey[200]),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: FutureBuilder<String>(
            future: userAuthorizedCheck.getUserInfo(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == '') {
                  return const AppIntroHome();
                } else {
                  return const HomePage();
                }
              } else if (snapshot.hasError) {
                return const AppIntroHome();
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
