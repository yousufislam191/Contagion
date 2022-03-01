import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/developers.dart';
import 'package:lu_ahatting_application/Utils/user_simple_preference.dart';
import 'package:lu_ahatting_application/head/headHomePage.dart';
import 'package:lu_ahatting_application/loader.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/openPage.dart';
import 'package:lu_ahatting_application/login_registration_verification/registration.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:lu_ahatting_application/student/studentHomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lu_ahatting_application/teacher/teacherHomePage.dart';
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

  String _email = '', _pass = '', _Svalue = '', _name = '';
  var _Tvalue;

  @override
  Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Lu Chatting Application',
//       initialRoute: "/",
//       routes: {
//         "/": (context) => openPage(),
//         // "/": (context) => developer(),
//       },

    final user = FirebaseAuth.instance.currentUser;
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
              if (snapshot.data == true) {
                return studentHomePage(
                  name: "Name",
                );
                // List<String> dept =
                //     List.filled(11, 'null'); // declare a String type List
                // dept[0] = 'BBA';
                // dept[1] = 'CSE';
                // dept[2] = 'English';
                // dept[3] = 'EEE';
                // dept[4] = 'Civil Engineering';
                // dept[5] = 'Architecture';
                // dept[6] = 'Law';
                // dept[7] = 'Islamic Studies';
                // dept[8] = 'Public Health';
                // dept[9] = 'Tourism & Hospitality Management';
                // dept[10] = 'Bangla';

                // List<String> identity =
                //     List.filled(2, 'null'); // declare a String type List
                // identity[0] = 'Student';
                // identity[1] = 'Teacher';

                // for (int i = 0; i < 11; i++) {
                //   String _dept = dept[i];
                //   for (int i = 0; i < 2; i++) {
                //     // we use loop for matchin collection with database
                //     String _identity =
                //         identity[i]; // convert List Srting to String
                //     try {
                //       // when user login then it will find user identity from database & keep the identity value in '_value' variable
                //       DocumentSnapshot value = FirebaseFirestore.instance
                //           .collection(_dept)
                //           .doc(_dept)
                //           .collection(_identity)
                //           .doc(user!.uid)
                //           .get() as DocumentSnapshot<Object?>;

                //       // getCurrentUserData(value);

                //       _Svalue = (value['identity']);

                //       _name = (value['name']);

                //       break;
                //     } catch (e) {
                //       print(e);
                //     }
                //   }
                // }

                // if (_Svalue == 'Student') {
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //     builder: (context) => studentHomePage(name: _name),
                //   //   ),
                //   // );
                //   return studentHomePage(
                //     name: _name,
                //   );
                // } else if (_Tvalue == 'Head') {
                //   return headHomePage(name: _name);
                // } else if (_Tvalue == 'Lecturer' ||
                //     _Tvalue == "Professor" ||
                //     _Tvalue == "Assistant Professor" ||
                //     _Tvalue == "Associate Professor") {
                //   return teacherHomePage(
                //     name: _name,
                //   );
                // }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              // if (snapshot.data == true) {
              //   return studentHomePage();
              // }
              return openPage();
            }),
        // initialRoute: "/",
        // routes: {
        //   // "/": (context) => openPage(),
        //   // // "/": (context) => registration(),

        // },
      ),
    );
  }
}
