import 'dart:convert';
import 'dart:developer';

import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/utils/program_list_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  clearRecent() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  setRecentSubject(Subject subject) async {
    final subList = await getRecentSubject();
    final List<Subject> newList = [];
    if (subList == null) {
      newList.add(subject);
      final json = newList.map((e) => e.toMap()).toList();
      final pref = await SharedPreferences.getInstance();
      pref.setString("recent", jsonEncode(json));
    } else {
      newList.add(subject);
      final condition = (subjectList.length < 5) ? subList.length : 4;
      for (int i = 0; i < condition; i++) {
        newList.add(subjectList[i]);
      }
      final json = newList.map((e) => e.toMap()).toList();
      final pref = await SharedPreferences.getInstance();
      pref.setString("recent", jsonEncode(json));
    }
  }

  Future<List<Subject>?> getRecentSubject() async {
    final pref = await SharedPreferences.getInstance();
    final response = pref.getString("recent");

    if (response != null) {
      final userMap = List<Map<String, dynamic>>.from(jsonDecode(response));
      final List<Subject> subList =
          userMap.map((e) => Subject.fromMap(e)).toList();
      log(subList.toString());
      return subList;
    }
    return null;
  }
}
