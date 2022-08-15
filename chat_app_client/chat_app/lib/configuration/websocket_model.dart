import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';

import '../providers/user_authorization_provider.dart';

class NotificationController {
  static final NotificationController _singleton =
      NotificationController._internal();

  StreamController<String> streamController =
      StreamController.broadcast(sync: true);

  IOWebSocketChannel? channel;
  late var channelStream = channel?.stream.asBroadcastStream();

  factory NotificationController() {
    return _singleton;
  }

  NotificationController._internal() {
    initWebSocketConnection();
  }

  initWebSocketConnection() async {
    var storedUserInfo = storage.getUserInfoStorage();
    Map storedData = await storedUserInfo;
    String userID = storedData['user_id'];

    print("conecting...");

    try {
      channel = IOWebSocketChannel.connect(
        Uri.parse('ws://10.0.2.2:8001/chat/$userID/'),
        pingInterval: const Duration(seconds: 10),
      );
    } on Exception catch (e) {
      print(e);
      return await initWebSocketConnection();
    }

    print("socket connection initializied");
    // broadcastNotifications();
    channel?.sink.done.then((dynamic _) => _onDisconnected());

    // return channel;
    // channel = await initWebSocketConnection();
  }

  void sendMessage(messageObject, Function messageListener) {
    try {
      channel?.sink.add(json.encode(messageObject));
      channelStream?.listen((data) {
        Map message = json.decode(data);
        messageListener(message);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void _onDisconnected() {
    initWebSocketConnection();
  }
  // broadcastNotifications() {
  //   channelStream?.listen((streamData) {
  //     streamController.add(streamData);
  //   }, onDone: () {
  //     print("conecting aborted");
  //     initWebSocketConnection();
  //   }, onError: (e) {
  //     print('Server error: $e');
  //     initWebSocketConnection();
  //   });
  // }

  // connectWs() async {
  //   try {
  //     return await WebSocket.connect();
  //   } catch (e) {
  //     print("Error! can not connect WS connectWs " + e.toString());
  //     await Future.delayed(const Duration(seconds: 10));
  //     return await connectWs();
  //   }
  // }

}
