import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationNotifierProvider = ChangeNotifierProvider.family(
    ((ref, bool notificationOn) => NotificationNotifier(notificationOn)));

class NotificationNotifier extends ChangeNotifier {
  final bool parentNotificationOn;
  late bool notificationOn;

  NotificationNotifier(this.parentNotificationOn);
}
