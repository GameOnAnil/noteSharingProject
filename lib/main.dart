import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_sharing_project/firebase_options.dart';
import 'package:note_sharing_project/ui/screens/home_page.dart';
import 'package:note_sharing_project/utils/my_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
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
          primaryColor: darkBlueBackground,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(backgroundColor: darkBlueBackground),
          textTheme: const TextTheme(),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: darkBlueBackground,
              foregroundColor: Colors.white),
        ),
        home: const HomePage(),
      ),
    );
  }
}
