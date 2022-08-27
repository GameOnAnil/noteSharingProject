import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/services/shared_pref_service.dart';

final recentFileNotifierProvider =
    ChangeNotifierProvider<RecentFileNotifier>((_) => RecentFileNotifier());

class RecentFileNotifier extends ChangeNotifier {
  List<Subject> _recentFileList = [];
  List<Subject> get recentFileList => _recentFileList;

  getRecentFiles() async {
    final response = await SharedPrefService().getRecentSubject();
    _recentFileList = response ?? [];
    notifyListeners();
  }
}
