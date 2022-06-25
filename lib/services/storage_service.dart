import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> getFiles() async {
    final result = await storage.ref("docs").listAll();
    List<String> fileList = [];
    for (var r in result.items) {
      final url = await storage.ref(r.fullPath).getDownloadURL();
      fileList.add(url);
    }

    return fileList;
  }
}
