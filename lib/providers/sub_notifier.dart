import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/services/db_helper.dart';
import 'package:note_sharing_project/utils/program_list_constant.dart';

final subNotifierProvider = ChangeNotifierProvider.autoDispose(
    ((ref) => SubNotifier(dbHelper: DbHelper.instance)));

class SubNotifier extends ChangeNotifier {
  final DbHelper dbHelper;
  List<Subject> subList = [];
  SubNotifier({
    required this.dbHelper,
  });

  Future<void> getSubByCategory(
      {required String program, required String semester}) async {
    final response =
        await dbHelper.getSubByCategory(program: program, semester: semester);
    subList = response;
    notifyListeners();
  }

  Future<void> insertSub(Subject sub) async {
    final response = await dbHelper.insertSubject(sub);
    log("Insert response:$response");
    notifyListeners();
  }

  Future<void> getSubByCategoryLocal(
      {required String program, required String semester}) async {
    final response = subjectList
        .where((element) =>
            (element.program == program && element.semester == semester))
        .toList();
    subList = response;
    notifyListeners();
  }
}
