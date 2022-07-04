import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/services/auth_service.dart';

final loginPageNotifierProvider = ChangeNotifierProvider(((ref) {
  final authService = ref.watch(authServiceProvider);
  return LoginPageNotifier(authService);
}));

class LoginPageNotifier extends ChangeNotifier {
  bool isLoading = false;
  final AuthService authService;
  String? error;

  LoginPageNotifier(this.authService);

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      final response = await authService.signIn(email, password);
      isLoading = false;
      notifyListeners();
      return response;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      error = e.message;
      notifyListeners();
    }
    return null;
  }
}
