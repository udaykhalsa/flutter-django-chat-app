import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:iconly/iconly.dart';

import '../configuration/websocket_model.dart';
import 'account_screen.dart';
import 'friends_screen.dart';
import 'message_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final notifiationController = NotificationController();

  @override
  void dispose() {
    notifiationController.initWebSocketConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 4,
          selectedItemColor: const Color.fromRGBO(53, 61, 96, 0.9),
          unselectedItemColor: Colors.grey[400],
          items: const [
            BottomNavigationBarItem(
              label: 'Messages',
              icon: Icon(Iconsax.message_21)
            ),
            BottomNavigationBarItem(
              label: 'Friends',
              icon: Icon(IconlyBold.user_2)
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(IconlyBold.profile),
            ),
          ],
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(
              () {
                currentIndex = index;
              },
            );
          },
        ),
      ),
    );
  }
}

final List<Widget> _pages = [
  const MessageHome(),
  const FriendsHome(),
  const AccountScreen(),
];
