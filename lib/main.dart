import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/Utils/user_simple_preference.dart';
import 'package:lu_ahatting_application/openPage.dart';
import 'package:lu_ahatting_application/openPage2.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  final storage = new FlutterSecureStorage();
  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lu Chatting Application',
        home: FutureBuilder(
            future: checkLoginStatus(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == false) {
                return openPage();
              }
              return openPage2();
            }),
      ),
    );
  }
}
