import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/services/auth_service.dart';
import 'package:note_sharing_project/ui/authentication/login_page/login_page_web.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page_builder.dart';

class AuthWrapperPageWeb extends ConsumerWidget {
  const AuthWrapperPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.watch(authServiceProvider).authStateChange,
      builder: ((context, snapshot) {
        if (snapshot.data != null) {
          return const HomePageBuilder();
        } else {
          return const LoginPageWeb();
        }
      }),
    );
  }
}
