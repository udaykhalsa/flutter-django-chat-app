import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:international_chat_app/configuration/conf.dart';

import '../configuration/websocket_model.dart';
import '../models/chat_messages_response.dart';
import '../providers/user_authorization_provider.dart';

import 'package:international_chat_app/models/chat_messages_list_response.dart';

class ChatMessage {
  String? content;
  int? room;
  String? user;
  DateTime? createdAt;

  String? message;
  String? toUser;
  ChatMessage({@required this.message, @required this.toUser});
}

class Messsages extends StatefulWidget {
  final String? userUid;
  final String? name;
  final int? roomID;
  const Messsages({Key? key, this.userUid, this.name, this.roomID})
      : super(key: key);

  @override
  State<Messsages> createState() => _MesssagesState();
}

class _MesssagesState extends State<Messsages> {
  final NotificationController notificationController =
      NotificationController();
  TextEditingController sendMessageController = TextEditingController();
  bool isLoading = false;
  List<ChatMessage> messages = [];
  List<dynamic> chatMessage = [];
  late int? messageRoomId;
  HttpService httpService = HttpService();
  late ChatMessagesResponse chatMessagesResponse;
  List<ChatMessagesListResponse> chatMessagesListResponse = [];

  void messageListener(Map message) {
    Map messageData = message;
    // if (messageData['message_room'] == messageRoomId) {
      setState(() {
        chatMessagesListResponse.add(ChatMessagesListResponse(
            messageId: messageData['message_id'],
            roomId: messageData['message_room'],
            messageContent: messageData['message_content'],
            fromMessageUser: messageData['message_user'],
            messageTime: messageData['message_created_at']));
      });
    // }
    print(messageData);
  }

  Future getRoomMessages() async {
    Response response;

    try {
      isLoading = true;

      if (widget.roomID == null) {
        response = await httpService
            .getChatRoomsResponse('api/v1/room-messages/${widget.userUid}/');
      } else {
        response = await httpService.getChatRoomsResponse(
            'api/v1/room-messages/${widget.userUid}/${widget.roomID}/');
      }

      setState(() {
        chatMessagesResponse = ChatMessagesResponse.fromJson(response.data);
        chatMessagesListResponse =
            chatMessagesResponse.chatMessagesListResponse;
        messageRoomId = chatMessagesListResponse.first.roomId;
      });

      isLoading = false;

      return chatMessagesListResponse;
    } on Exception catch (_) {
      isLoading = false;
      return true;
    }
  }

  late final Future? myFuture = getRoomMessages();

  @override
  void initState() {
    getRoomMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/e0/41/fa/e041fa5038a055ff62d51fdbcc15dbc9.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.name as String,
                // widget.name as String,
                style: const TextStyle(color: Colors.black87, fontSize: 18.0),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(child: Text('Block')),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: chatMessagesListResponse.length,
                      itemBuilder: (BuildContext context, int index) {
                        final chatMessage1 = chatMessagesListResponse[index];
                        return Stack(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(14, 10, 14, 10),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    chatMessage1.fromMessageUser !=
                                            widget.userUid
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: chatMessage1.fromMessageUser !=
                                              widget.userUid
                                          ? Colors.grey.shade400
                                          : Colors.grey.shade300,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      chatMessage1.messageContent as String,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Material(
                  elevation: 12.0,
                  child: Container(
                    color: Colors.grey[100],
                    constraints: const BoxConstraints(maxHeight: 150),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 4.0, 15.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              autofocus: true,
                              controller: sendMessageController,
                              autocorrect: true,
                              enableSuggestions: false,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                hintText: 'Message',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            focusColor: Colors.black,
                            onPressed: () {
                              var messageObject = {
                                'message': sendMessageController.text,
                                'to_user': widget.userUid,
                              };
                              sendMessageController.clear();
                              notificationController.sendMessage(
                                  messageObject, messageListener);
                            },
                            icon: const Icon(Iconsax.send_14),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
