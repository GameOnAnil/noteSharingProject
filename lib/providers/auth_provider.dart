import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProviderNotifier = ChangeNotifierProvider((_) => MyAuthProvider());

class MyAuthProvider extends ChangeNotifier {
  UserCredential? user;

  setUser(UserCredential u) {
    user = u;
    notifyListeners();
  }

  reset() {
    user = null;
    notifyListeners();
  }
}
