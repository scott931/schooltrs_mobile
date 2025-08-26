import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider extends ChangeNotifier {
  static const String _notificationBox = 'notification_box';

  final FlutterLocalNotificationsPlugin _flutterNotifications =
      FlutterLocalNotificationsPlugin();
  final List<Map<String, dynamic>> _notifications = [];

  List<Map<String, dynamic>> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n['read']).length;

  static Future<void> initialize() async {
    // Initialize local notifications
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await FlutterLocalNotificationsPlugin().initialize(initSettings);
  }

  Future<void> addNotification({
    required String title,
    required String message,
    required String type,
    String? actionUrl,
  }) async {
    final notification = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'message': message,
      'type': type,
      'timestamp': DateTime.now().toIso8601String(),
      'read': false,
      'actionUrl': actionUrl,
    };

    _notifications.insert(0, notification);
    notifyListeners();

    // Show local notification
    await _showLocalNotification(notification);
  }

  Future<void> markAsRead(String notificationId) async {
    final index = _notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      _notifications[index]['read'] = true;
      notifyListeners();
    }
  }

  Future<void> markAllAsRead() async {
    for (var notification in _notifications) {
      notification['read'] = true;
    }
    notifyListeners();
  }

  Future<void> clearNotifications() async {
    _notifications.clear();
    notifyListeners();
  }

  Future<void> _showLocalNotification(Map<String, dynamic> notification) async {
    const androidDetails = AndroidNotificationDetails(
      'school_transport',
      'School Transport',
      channelDescription: 'Notifications from School Transport app',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterNotifications.show(
      int.parse(notification['id']),
      notification['title'],
      notification['message'],
      details,
    );
  }
}
