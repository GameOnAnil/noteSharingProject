import 'dart:developer';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:note_sharing_project/utils/constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  // final _dio = Dio();
  final Dio _dio = Dio();

  NotificationService() {
    _dio.interceptors.add(ChuckerDioInterceptor());
  }
  Future<void> sendToAllNotification(
      {required String heading, required String content}) async {
    try {
      final response = await _dio.post(
        'https://onesignal.com/api/v1/notifications',
        options: Options(
          headers: {
            "Authorization": "Basic $oneSignalRestApi",
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          "included_segments": ["Subscribed Users"],
          "app_id": oneSignalId,
          "headings": {"en": heading},
          "contents": {"en": content}
        },
      );
      log(response.data);
    } catch (e) {
      log("ERRROR:$e");
    }
  }

  sendNotificationTag(String tag) async {
    OneSignal.shared.sendTag(tag, tag);
  }

  removeNotificationTag(String tag) async {
    OneSignal.shared.sendTag(tag, tag);
  }

  Future<void> sendWithTagNotification(
      {required String heading,
      required String content,
      required String tag}) async {
    try {
      log("send notification with tag called");
      await _dio.post(
        'https://onesignal.com/api/v1/notifications',
        options: Options(
          headers: {
            "Authorization": "Basic $oneSignalRestApi",
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          "filters": [
            {"field": "tag", "key": tag, "relation": "exists"}
          ],
          "app_id": oneSignalId,
          "headings": {"en": heading},
          "contents": {"en": content}
        },
        onSendProgress: (i, j) {
          log("i=$i and j= $j");
        },
      );
    } catch (e) {
      log("ERRROR:$e");
    }
  }
}
