import 'dart:developer';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_sharing_project/firebase_options.dart';
import 'package:note_sharing_project/ui/splash/splash_screen/splash_screen.dart';
import 'package:note_sharing_project/utils/my_colors.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    log("Platform ios or android");
    await initOneSignal();
  }

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
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            navigatorObservers: [ChuckerFlutter.navigatorObserver],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              colorScheme:
                  const ColorScheme.light().copyWith(primary: purplePrimary),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: purplePrimary,
                  foregroundColor: Colors.white),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
