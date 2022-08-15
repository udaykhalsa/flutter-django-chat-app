import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:provider/provider.dart';

import '/providers/friend_list_provider.dart';
import '/screens/messages_screen.dart';
import '/screens/user_profile_screen.dart';
import 'search_user.dart';

class FriendsHome extends StatefulWidget {
  const FriendsHome({Key? key}) : super(key: key);

  @override
  State<FriendsHome> createState() => _FriendsHomeState();
}

class _FriendsHomeState extends State<FriendsHome> {
  late FriendsProvider friendsProvider;

  Future<void> _pullRefresh() async {
    friendsProvider.getFriends();
    friendsProvider.getFriendRequests();
  }

  @override
  void initState() {
    friendsProvider = Provider.of<FriendsProvider>(context, listen: false);
    friendsProvider.getFriends();
    friendsProvider.getFriendRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          AppBar(
            toolbarHeight: 75.0,
            title: const Text('Friends'),
            actions: [
              IconButton(
                focusColor: Colors.black,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => SearchUser(),
                    ),
                  );
                },
                icon: const Icon(Iconsax.user_search),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12.0)),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color.fromRGBO(245, 117, 106, 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                tabs: [
                  Tab(
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Friends',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Requests',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Consumer<FriendsProvider>(
            builder: (context, friendsListProvider, _) {
              return Expanded(
                child: TabBarView(
                  children: [
                    RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: friendsListProvider.friendUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final friendUser =
                              friendsListProvider.friendUsers[index];
                          if (friendsListProvider.friendUsers.isEmpty) {
                            return const Center(
                              child: Text('No friends yet'),
                            );
                          } else {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserProfile(
                                      userUid: friendUser.user_uid as String,
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
                                friendUser.username as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              isThreeLine: false,
                              subtitle: Text(
                                // 'dadas',
                                friendUser.about_me as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Messsages(
                                            userUid:
                                                friendUser.user_uid as String,
                                            name: friendUser.name as String,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Iconsax.message_text,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: friendsListProvider.friendRequestUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final friendRequestUserIndividual =
                            friendsListProvider.friendRequestUsers[index];
                        return ListTile(
                          onTap: () {},
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/originals/e0/41/fa/e041fa5038a055ff62d51fdbcc15dbc9.jpg'),
                            radius: 30.0,
                          ),
                          title: Text(
                            // 'dadas',

                            friendRequestUserIndividual.username as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          isThreeLine: false,
                          subtitle: const Text(
                            'Mumbai, India',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  friendsListProvider.friendRequestAction(
                                      friendRequestUserIndividual.requestId
                                          as int,
                                      'accept');
                                  friendsListProvider.getFriendRequests();
                                  friendsListProvider.getFriends();
                                },
                                icon: const Icon(
                                  Iconsax.check,
                                  // UniconsLine.check_circle,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  friendsListProvider.friendRequestAction(
                                      friendRequestUserIndividual.requestId
                                          as int,
                                      'decline');
                                  friendsListProvider.getFriendRequests();
                                },
                                icon: const Icon(
                                  Iconsax.colors_square,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // friendRequestList(friendsListProvider.friendRequestUsers),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
