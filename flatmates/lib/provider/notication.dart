import 'package:flatmates/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationManager(this._notificationsPlugin);

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/done');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel(
      'newmessagealert',
      'Notification Channel Name',
      description: 'Description of your notification channel',
      importance: Importance.max,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> showNotification(String sender, String message) async {
    try {
      print("inside notificaion");
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'newmessagealert',
        'Notification Channel Name',
        channelDescription: 'Description of your notification channel',
        priority: Priority.max,
        importance: Importance.max,
      );
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await _notificationsPlugin.show(
        0,
        sender,
        message,
        notificationDetails,
      );
    } catch (e) {
      print("Notificaiotn : ${e}");
    }
  }
}
