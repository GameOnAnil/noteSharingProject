import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/services/firebase_service.dart';

final filePageNotiferProvicer =
    ChangeNotifierProvider(((ref) => FilePageNotifer()));

class FilePageNotifer extends ChangeNotifier {
  FirebaseService firebaseService = FirebaseService();
  bool isSearchVisible = false;
  String orderBy = "name";
  List<FileModel> fileList = [];
  List<FileModel> newFileList = [];

  FilePageNotifer() {
    getFiles();
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

  void getFiles() async {
    final response =
        firebaseService.getFiles(path: "BESE-1st-C", orderBy: orderBy);
    response.listen((event) {
      fileList = event;
      newFileList = event;
      notifyListeners();
    });
  }

  void enableSearch() {
    isSearchVisible = !isSearchVisible;
    notifyListeners();
  }

  void orderedBy(String value) {
    orderBy = value;
    getFiles();
  }
}
