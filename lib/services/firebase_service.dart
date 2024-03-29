import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_sharing_project/models/files_model.dart';
import 'package:note_sharing_project/models/report_file_model.dart';
import 'package:note_sharing_project/models/user_model.dart';
import 'package:note_sharing_project/utils/auth_module.dart';

class FirebaseService {
  final firestore = FirebaseFirestore.instance;

  Stream<List<FileModel>> getFiles(
      {required String path, required String orderBy}) {
    return firestore
        .collection("files")
        .doc(path)
        .collection("data")
        .orderBy(orderBy)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => FileModel.fromMap(e.data(), e.id)).toList(),
        );
  }

  Stream<List<ReportFileModel>> getReportedFiles() {
    return firestore.collection("report").snapshots().map(
          (event) =>
              event.docs.map((e) => ReportFileModel.fromMap(e.data())).toList(),
        );
  }

  Future<void> insertData(String path, FileModel fileModel) async {
    final collectionRef =
        firestore.collection("files").doc(path).collection("data");

    await collectionRef.doc().set(fileModel.toMap());
  }

  Future<void> insertReportFile(
    String path,
    FileModel fileModel,
    String report,
  ) async {
    final collectionRef = firestore.collection("report");

    await collectionRef.doc(fileModel.documentId).set(
          ReportFileModel(
            name: fileModel.name,
            date: fileModel.date,
            time: fileModel.time,
            size: fileModel.size,
            filePath: fileModel.filePath,
            fileType: fileModel.fileType,
            url: fileModel.url,
            path: path,
            documentId: fileModel.documentId,
            report: report,
            reporterEmail: AuthModule.shared.userModel?.email ?? "",
            reporterName: AuthModule.shared.userModel?.name ?? "",
          ).toMap(),
        );
  }

  Future<void> deleteAllReportedFile(ReportFileModel model) async {
    try {
      final collectionRef = firestore.collection("report");
      final fileCollectionRef = firestore
          .collection("files")
          .doc(model.path)
          .collection("data")
          .doc(model.documentId);
      await fileCollectionRef.delete();
      await collectionRef.doc(model.documentId).delete();
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  Future<void> deleteReportedFileOnly(ReportFileModel model) async {
    try {
      final collectionRef = firestore.collection("report");
      await collectionRef.doc(model.documentId).delete();
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  Future<void> deleteFile(FileModel model, String path) async {
    try {
      log("path$path");
      log(model.toString());
      final collectionRef = firestore.collection("report");
      final fileCollectionRef = firestore
          .collection("files")
          .doc(path)
          .collection("data")
          .doc(model.documentId);
      await fileCollectionRef.delete();
      await collectionRef.doc(model.documentId).delete();
    } on FirebaseException catch (e) {
      log("delete file error:${e.message}");
    } catch (e) {
      log("delete file error:$e");
    }
  }

  Future<void> insertUser(UserCredential response) async {
    if (response.user != null) {
      final collectionRef = firestore.collection("users");
      await collectionRef
          .doc(response.user!.uid)
          .set(
            UserModel(
                    id: response.user?.uid ?? "",
                    name: response.user!.displayName ?? "",
                    email: response.user!.email ?? "",
                    userType: "user")
                .toMap(),
          )
          .onError((error, stackTrace) => null);
    }
  }

  static Future<String> getUserType(String uid) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      String type = await doc.get("userType");
      return type;
    } else {
      return "loading";
    }
  }
}
