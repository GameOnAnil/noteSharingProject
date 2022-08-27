import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/subject.dart';
import 'package:note_sharing_project/services/db_helper.dart';
import 'package:note_sharing_project/services/firebase_service.dart';

final filePageNotifierProvider = ChangeNotifierProvider.family(
    ((ref, String path) => FilePageNotifer(path: path)));

class FilePageNotifer extends ChangeNotifier {
  FirebaseService firebaseService = FirebaseService();
  bool isSearchVisible = false;
  String orderBy = "name";

  List<FileModel> fileList = [];
  List<FileModel> newFileList = [];

  bool isLoading = false;
  final String path;

  Subject? subject;

  initSubject(Subject newSub) {
    subject ??= newSub;
  }

  getNewSubject({required String name}) async {
    final response = await DbHelper.instance.getSubById(name: name);
    log("res from db:${response.toString()}");
    subject = response;
    notifyListeners();
  }

  Future<void> setNotification() async {
    if (subject != null) {
      await DbHelper.instance.updateSubject(
          subject!.copyWith(notificationOn: !subject!.notificationOn));
    }
  }

  FilePageNotifer({required this.path}) {
    getFiles(path);
  }

  void sortByName() {
    fileList.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void search(String value) {
    if (value.isNotEmpty) {
      newFileList = [];
      fileList.map((e) {
        final matched = e.name.contains(value);
        if (matched) {
          newFileList.add(e);
        }
      }).toList();

      notifyListeners();
    } else {
      newFileList = fileList;
      notifyListeners();
    }
  }

  void getFiles(String path) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = firebaseService.getFiles(path: path, orderBy: orderBy);
      response.listen((event) {
        fileList = event;
        newFileList = event;
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  void enableSearch() {
    isSearchVisible = !isSearchVisible;
    notifyListeners();
  }

  void orderedBy(String value) {
    orderBy = value;
    getFiles(path);
  }
}
