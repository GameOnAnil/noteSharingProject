import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_sharing_project/models/files_model.dart';

class FirebaseService {
  final firestore = FirebaseFirestore.instance;

  Stream<List<FileModel>> getFiles({required String path}) {
    return firestore
        .collection("files")
        .doc(path)
        .collection("data")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => FileModel.fromMap(e.data())).toList());
  }

  Future<void> insertData(String path) async {
    final collectionRef =
        firestore.collection("files").doc(path).collection("data");

    for (var element in dummyFileList) {
      await collectionRef.doc().set(element.toMap());
    }
  }
}
