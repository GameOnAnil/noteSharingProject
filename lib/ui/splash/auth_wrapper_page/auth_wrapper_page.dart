import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:note_sharing_project/models/user_model.dart';
import 'package:note_sharing_project/providers/auth_provider.dart';
import 'package:note_sharing_project/services/api_service.dart';
import 'package:note_sharing_project/ui/admin/admin_home_page/admin_home_page.dart';
import 'package:note_sharing_project/ui/authentication/login_page/login_page.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page_builder.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page_new.dart';

import '../../../utils/base_page.dart';
import '../../../utils/base_state.dart';

class AuthWrapperPage extends BaseStatefulWidget {
  const AuthWrapperPage({Key? key}) : super(key: key);

  @override
  BaseState<AuthWrapperPage> createState() => _AuthWrapperPageState();
}

class _AuthWrapperPageState extends BaseState<AuthWrapperPage> {
  @override
  Widget build(BuildContext context) {
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
                return const HomePageNew();
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
