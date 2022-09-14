import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/models/user_model.dart';
import 'package:note_sharing_project/providers/auth_provider.dart';
import 'package:note_sharing_project/services/api_service.dart';
import 'package:note_sharing_project/services/auth_service.dart';
import 'package:note_sharing_project/services/firebase_service.dart';
import 'package:note_sharing_project/ui/admin/admin_home_page/admin_home_page.dart';
import 'package:note_sharing_project/ui/authentication/login_page/login_page.dart';
import 'package:note_sharing_project/ui/home/home_page/home_page.dart';

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
              return const HomePage();
            } else {
              return const Scaffold(body: SizedBox());
            }
          }
        },
      );
    }
  }

  StreamBuilder<User?> _buildStreamBuilder(WidgetRef ref) {
    return StreamBuilder(
      stream: ref.watch(authServiceProvider).authStateChange,
      builder: ((context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data != null) {
          return FutureBuilder(
            future: FirebaseService.getUserType(snapshot.data?.uid ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("error..${snapshot.error}"),
                );
              } else {
                final userType = snapshot.data;
                log("user type$userType");
                if (userType == "admin") {
                  return const AdminHomePage();
                } else if (userType == "user") {
                  return const HomePage();
                } else {
                  return const Scaffold(body: SizedBox());
                }
              }
            },
          );
        } else {
          return const LoginPage();
        }
      }),
    );
  }
}
