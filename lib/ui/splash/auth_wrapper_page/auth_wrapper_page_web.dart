import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/ui/admin/admin_home_page/admin_home_page.dart';
import 'package:note_sharing_project/ui/authentication/login_page/login_page_web.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page_builder.dart';

import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/api_service.dart';

class AuthWrapperPageWeb extends ConsumerWidget {
  const AuthWrapperPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("authwrapper page build");
    final uid = ref.watch(authProviderNotifier).userId;
    log("uid$uid");
    if (uid == null) {
      return const LoginPageWeb();
    } else {
      return FutureBuilder(
        // future: FirebaseService.getUserType(userCredential.user?.uid ?? ""),
        future: ApiService().getUsers(id: uid ?? ""),
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
              return const HomePageBuilder();
            } else {
              return const Scaffold(body: SizedBox());
            }
          }
        },
      );
    }
  }
}
