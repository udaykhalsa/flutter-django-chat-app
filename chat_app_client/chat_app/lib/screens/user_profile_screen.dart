import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import '/providers/user_profile_provider.dart';
import '/screens/messages_screen.dart';

class UserProfile extends StatefulWidget {
  final String userUid;
  const UserProfile({Key? key, required this.userUid}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserProfileProvider userProfileProvider;
  dynamic userProfilePicture;

  @override
  void initState() {
    userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white12,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => Messsages(
                userUid: widget.userUid,
                name: userProfileProvider.userProfileResponse.username,
              ),
            ),
          );
        },
        backgroundColor: const Color.fromRGBO(245, 117, 106, 1),
        foregroundColor: Colors.black87,
        child: const Icon(Iconsax.message5),
      ),
      body: FutureBuilder(
        future: userProfileProvider.getUserProfileData(widget.userUid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (userProfileProvider.userProfileResponse.profilePicture !=
                null) {
              userProfilePicture = NetworkImage(
                  '${userProfileProvider.userProfileResponse.profilePicture}');
            } else {
              userProfilePicture = const NetworkImage(
                      'https://i.pinimg.com/originals/e0/41/fa/e041fa5038a055ff62d51fdbcc15dbc9.jpg');
            }

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: userProfilePicture),
                            shape: BoxShape.circle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userProfileProvider
                                    .userProfileResponse.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                            ],
                          ),
                          userProfileProvider.userProfileResponse.isFriend
                              ? TextButton.icon(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,

                                          // color: ,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                TextButton(
                                                  child:
                                                      Text('Modal BottomSheet'),
                                                  onPressed: () {},
                                                ),
                                                Divider(),
                                                TextButton(
                                                  child:
                                                      Text('Modal BottomSheet'),
                                                  onPressed: () {},
                                                ),
                                                Divider(),
                                                TextButton(
                                                  child:
                                                      Text('Modal BottomSheet'),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Iconsax.user_tick,
                                      color: Colors.black),
                                  label: const Text(
                                    'Friends',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(245, 117, 106, 1),
                                  ),
                                )
                              : userProfileProvider
                                      .userProfileResponse.sender
                                  ? TextButton.icon(
                                      onPressed: () {
                                        // sendFriendRequest();
                                      },
                                      icon: const Icon(Iconsax.user_remove,
                                          color: Colors.black),
                                      label: const Text(
                                        'Accept',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        backgroundColor: const Color.fromRGBO(
                                            245, 117, 106, 1),
                                      ),
                                    )
                                  : userProfileProvider
                                          .userProfileResponse.receiver
                                      ? TextButton.icon(
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: 200,

                                                    // color: ,
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          TextButton(
                                                            child: Text(
                                                                'Modal BottomSheet'),
                                                            onPressed: () {},
                                                          ),
                                                          Divider(),
                                                          TextButton(
                                                            child: Text(
                                                                'Modal BottomSheet'),
                                                            onPressed: () {},
                                                          ),
                                                          Divider(),
                                                          TextButton(
                                                            child: Text(
                                                                'Modal BottomSheet'),
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                            // sendFriendRequest();
                                          },
                                          icon: const Icon(Iconsax.user_minus4,
                                              color: Colors.black),
                                          label: const Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    245, 117, 106, 1),
                                          ),
                                        )
                                      : TextButton.icon(
                                          onPressed: () {
                                            // sendFriendRequest();
                                          },
                                          icon: const Icon(Iconsax.user_add,
                                              color: Colors.black),
                                          label: const Text(
                                            'Add Friend',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    245, 117, 106, 1),
                                          ),
                                        ),
                        ],
                      ),
                    ),
                    const Text(
                      'About Me',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        userProfileProvider.userProfileResponse.aboutMe,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.2,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
