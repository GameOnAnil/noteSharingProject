import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/user_model.dart';
import 'package:note_sharing_project/providers/auth_provider.dart';
import 'package:note_sharing_project/services/api_service.dart';
import 'package:note_sharing_project/ui/admin/admin_home_page/admin_home_page.dart';
import 'package:note_sharing_project/ui/authentication/login_page/login_page.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page_builder.dart';

class AuthWrapperPage extends ConsumerWidget {
  const AuthWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("authwrapper page build");
    final uid = ref.watch(authProviderNotifier).userId;
    log("uid$uid");
    if (uid == null) {
      return const LoginPage();
    } else {
      return FutureBuilder(
        future: ApiService().getUsers(id: uid),
        builder: (context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("error..${snapshot.error}"),
              ),
            );
          } else {
            final user = snapshot.data;
            log("user type${user?.userType}");
            if (user?.userType == "admin") {
              return const AdminHomePage();
            } else if (user?.userType == "user") {
              if (!kIsWeb) {
                return const HomePage();
              } else {
                return const HomePageBuilder();
              }
            } else {
              return const Scaffold(body: SizedBox());
            }
          }
        },
      );
    }
  }
}
