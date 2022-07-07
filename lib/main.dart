import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/firebase_options.dart';
import 'package:note_sharing_project/ui/screens/auth_wrapper_page.dart';
import 'package:note_sharing_project/utils/my_colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initOneSignal();
  runApp(const MyApp());
}

Future<void> initOneSignal() async {
  OneSignal.shared.setAppId("e892472a-859e-47a0-927c-a95086253dfe");
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    log('NOTIFICATION OPENED HANDLER CALLED WITH: $result');
  });

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    log('FOREGROUND HANDLER CALLED WITH: $event');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          // colorScheme: ColorScheme.fromSwatch(
          //   primarySwatch: Colors.deepPurple,
          // ).copyWith(
          //   primary: darkBlueBackground,
          // ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: darkBlueBackground,
              foregroundColor: Colors.white),
        ),
        home: const AuthWrapperPage(),
      ),
    );
  }
}
