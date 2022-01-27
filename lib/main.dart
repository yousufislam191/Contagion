import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/loginPage.dart';
import 'package:lu_ahatting_application/openPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      initialRoute: "/",
      routes: {
        "/": (context) => openPage(),
        // "/": (context) => loginPage(),
      },
    );
  }
}
