import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_sharing_project/models/user_model.dart';
import 'package:note_sharing_project/services/api_service.dart';

final authServiceProvider = Provider(((ref) => AuthService()));

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  AuthService();

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return response;
    } on FirebaseAuthException catch (e) {
      log("ERROR:$e");
      rethrow;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // await FirebaseService().insertUser(response);
      if (response.user != null) {
        await ApiService().postUser(
            user: UserModel(
          id: response.user!.uid,
          name: response.user?.displayName ?? "",
          email: email,
          userType: "user",
        ));
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<UserCredential?> googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {}

      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  String? getUser() {
    return _firebaseAuth.currentUser?.uid;
  }
}
