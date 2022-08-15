import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:international_chat_app/configuration/conf.dart';
import 'package:international_chat_app/models/message_list_response.dart';

import '../models/message_list_data_response.dart';
import 'messages_screen.dart';

class MessageHome extends StatefulWidget {
  const MessageHome({Key? key}) : super(key: key);

  @override
  State<MessageHome> createState() => _MessageHomeState();
}

class _MessageHomeState extends State<MessageHome> {
  bool isLoading = false;
  HttpService http = HttpService();

  late MessagesListResponse messagesListResponse;
  List<MessageListDataResponse> messageListData = [];

  Future getChatRooms() async {
    Response response;

    try {
      isLoading = true;

      response = await http.getChatRoomsResponse('api/v1/user-chatrooms/');

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          messagesListResponse = MessagesListResponse.fromJson(response.data);
          messageListData = messagesListResponse.messagesListDataResponse;
        });
        return true;
      } else {
        return true;
      }
    } on Exception catch (_) {
      isLoading = false;
      return true;
    }
  }

  late final Future getMessagesListVar = getChatRooms();

  @override
  void initState() {
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          toolbarHeight: 75.0,
          title: const Text('Chats'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.more),
            ),
          ],
        ),
        FutureBuilder(
          future: getMessagesListVar,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                  primary: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: messageListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final messageData = messageListData[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Messsages(
                              roomID: messageData.roomId,
                              userUid: messageData.userUserUid,
                              name: messageData.userUsername,
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
                        messageData.userUsername as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      horizontalTitleGap: 10.0,
                      isThreeLine: false,
                      subtitle: Text(
                        messageData.roomLastMessage as String,
                        // messageListData[''],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
