import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/openPage.dart';

void main() {
  runApp(const MyApp());
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
      },
    );
  }
}
