import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProviderNotifier = ChangeNotifierProvider((_) => MyAuthProvider());

class MyAuthProvider extends ChangeNotifier {
  String? userId;

  setUser(String u) {
    userId = u;
    notifyListeners();
  }

  reset() {
    userId = null;
    notifyListeners();
  }
}
