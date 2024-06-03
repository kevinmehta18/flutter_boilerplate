import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsManager {
  static late PushNotificationsManager _instance;
  late FirebaseMessaging _firebaseMessaging;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  PushNotificationsManager._internal();

  List<String> messages = [];
  List<String> notificationIds = [];
  int notificationId = -1;


  static PushNotificationsManager getInstance() {
    _instance = PushNotificationsManager._internal();
    _instance._firebaseMessaging = FirebaseMessaging.instance;
    return _instance;
  }

  Future init() async {

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
    // _firebaseMessaging.getInitialMessage().then(_handleMessage);

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()
      ),
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }


  Future<void> handleMessage(RemoteMessage message) async {
    debugPrint('handlePushNotification: ${message.data.toString()}');

    if (message.data['url'] != null) {
    }
  }

  /// Background notification handler
  @pragma('vm:entry-point')
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("background");
    handleForegroundMessage(message);
  }

  void handleForegroundMessage(RemoteMessage message) {
    // if (kDebugMode) {
      print('message-------${message.toMap().toString()}');
    // }
    if (message.data.isNotEmpty &&notificationId != int.parse(message.data['idContent'].toString())) {
      messages.clear();
      notificationIds.clear();
    }
    notificationId = int.parse(message.data['idContent'].toString());
    messages.add(message.data['body'].toString());
    notificationIds.add(message.data['idContent'].toString());

    int id =  int.parse(message.data['idContent'].toString());
    String title = message.data['title'];
    String body =  message.data['body'];
    String groupKey =  message.data['idContent'].toString();

    if (message.data.isNotEmpty) {
      flutterLocalNotificationsPlugin.show(
          id,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'com.google.firebase.messaging.default_notification_channel_id',
              'Channel Name',
              groupKey: groupKey,
              fullScreenIntent: true,
              playSound: true,
              importance: Importance.high,
              priority: Priority.high,
              styleInformation: InboxStyleInformation(
                messages,
              ),
            ),
          ),
          payload: jsonEncode(message.data));
    }
  }

  void onSelectNotification(NotificationResponse? response) {
    if (kDebugMode) {
      print('onSelectNotification: ${response?.payload}');
    }
    messages.clear();
    String? payload = response?.payload;
    debugPrint('onSelectNotification: $payload');
    var data = jsonDecode(payload!);
   
  }

}
