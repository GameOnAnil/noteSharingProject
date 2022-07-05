import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:note_sharing_project/utils/constants.dart';

class NotificationService {
  final _dio = Dio();
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

  Future<void> sendWithTagNotification(
      {required String heading,
      required String content,
      required String tag}) async {
    try {
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
      );
    } catch (e) {
      log("ERRROR:$e");
    }
  }
}
