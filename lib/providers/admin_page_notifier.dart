import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/report_file_model.dart';
import 'package:note_sharing_project/services/firebase_service.dart';

final adminPageNotifierProvider =
    ChangeNotifierProvider((_) => AdminPageNotifier());

class AdminPageNotifier extends ChangeNotifier {
  FirebaseService firebaseService = FirebaseService();

  List<ReportFileModel> reportFileList = [];
  bool isLoading = false;

  Future<void> getReportFiles() async {
    try {
      final response = firebaseService.getRecentFiles();
      response.listen((event) {
        reportFileList = event;
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
