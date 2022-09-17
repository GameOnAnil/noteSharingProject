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
  bool isLoading = true;

  Future<void> getReportFiles() async {
    try {
      final response = firebaseService.getReportedFiles();
      response.listen((event) {
        reportFileList = event;
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }
}
