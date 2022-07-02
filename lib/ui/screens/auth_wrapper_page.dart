import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/services/auth_service.dart';
import 'package:note_sharing_project/ui/screens/home_page.dart';
import 'package:note_sharing_project/ui/screens/login_page.dart';

class AuthWrapperPage extends ConsumerWidget {
  const AuthWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.watch(authServiceProvider).authStateChange,
      builder: ((context, snapshot) {
        if (snapshot.data != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      }),
    );
  }
}
