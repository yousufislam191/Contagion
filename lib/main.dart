import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/developers.dart';
import 'package:lu_ahatting_application/Utils/user_simple_preference.dart';
import 'package:lu_ahatting_application/head/headHomePage.dart';
import 'package:lu_ahatting_application/loader.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';
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
                setStatus();
                // return openPage();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              // if (snapshot.data == false) {
              //   return openPage();
              // }
              // if (snapshot.data == true) {
              //   return studentHomePage();
              // }
              return openPage();
            }),
        // initialRoute: "/",
        // routes: {
        //   // "/": (context) => openPage(),
        //   // // "/": (context) => registration(),

        //         // if (_Svalue == 'Student') {
        //         //   // Navigator.push(
        //         //   //   context,
        //         //   //   MaterialPageRoute(
        //         //   //     builder: (context) => studentHomePage(name: _name),
        //         //   //   ),
        //         //   // );
        //         //   return studentHomePage(
        //         //     name: _name,
        //         //   );
        //         // } else if (_Tvalue == 'Head') {
        //         //   return headHomePage(name: _name);
        //         // } else if (_Tvalue == 'Lecturer' ||
        //         //     _Tvalue == "Professor" ||
        //         //     _Tvalue == "Assistant Professor" ||
        //         //     _Tvalue == "Associate Professor") {
        //         //   return teacherHomePage(
        //         //     name: _name,
        //         //   );
        //         // }
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Container(
        //           color: Colors.white,
        //           child: Center(
        //             child: CircularProgressIndicator(),
        //           ),
        //         );
        //       }
        //       // if (snapshot.data == true) {
        //       //   return studentHomePage();
        //       // }
        //       return openPage();
        //     }),
        initialRoute: "/",
        routes: {
          "/": (context) => openPage(),
          //   // // "/": (context) => registration(),
        },
      ),
    );
  }

  Future setStatus() async {
    // await FirebaseFirestore.instance..collection('users').doc(_auth.currentUser!.uid).update({
    //   "status": status,
    // });
    // await currentUserValue.update({
    //   "status": status,
    // });
    // print("work");
    final user = FirebaseAuth.instance.currentUser;
    List<String> dept = List.filled(11, 'null');
    dept[0] = 'BBA';
    dept[1] = 'CSE';
    dept[2] = 'English';
    dept[3] = 'EEE';
    dept[4] = 'Civil Engineering';
    dept[5] = 'Architecture';
    dept[6] = 'Law';
    dept[7] = 'Islamic Studies';
    dept[8] = 'Public Health';
    dept[9] = 'Tourism & Hospitality Management';
    dept[10] = 'Bangla';

    List<String> identity = List.filled(2, 'null');
    identity[0] = 'Student';
    identity[1] = 'Teacher';

    for (int i = 0; i < 11; i++) {
      String _dept = dept[i];
      for (int i = 0; i < 2; i++) {
        String _identity = identity[i];
        // print("work");

        try {
          DocumentSnapshot value = await FirebaseFirestore.instance
              .collection(_dept)
              .doc(_dept)
              .collection(_identity)
              .doc(user?.uid)
              .get();

          _Svalue = (value['identity']);

          _name = (value['name']);

          if (_Svalue == 'Student') {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => studentHomePage(name: _name),
            //   ),
            // );
            print("working");
            return studentHomePage(currentUserValue: value);
            // print("work");
          } else if (_Tvalue == 'Head') {
            return headHomePage(currentUserValue: value);
          } else if (_Tvalue == 'Lecturer' ||
              _Tvalue == "Professor" ||
              _Tvalue == "Assistant Professor" ||
              _Tvalue == "Associate Professor") {
            return teacherHomePage(
              currentUserValue: value,
            );
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
