import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';

class Ppage extends StatefulWidget {
  final currentUserValue;
  const Ppage({Key? key, this.currentUserValue}) : super(key: key);

  @override
  _PpageState createState() => _PpageState(currentUserValue);
}

class _PpageState extends State<Ppage> {
  final currentUserValue;
  final user = FirebaseAuth.instance.currentUser;
  final storage = new FlutterSecureStorage();

  _PpageState(this.currentUserValue);

  late double height, width;

  void setStatus() async {
    UserModel _getCurrentUserData = new UserModel.fromMap(currentUserValue);
    try {
      await FirebaseFirestore.instance
          .collection(_getCurrentUserData.department.toString())
          .doc(_getCurrentUserData.department.toString())
          .collection(_getCurrentUserData.identity.toString())
          .doc(_getCurrentUserData.uid)
          .update({
        "status": 'Offline',
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    UserModel _getCurrentUserData = new UserModel.fromMap(currentUserValue);
    String name = _getCurrentUserData.name.toString();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: new Icon(
                    Icons.arrow_back_outlined,
                    color: Color(0xff49c42b),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(_getCurrentUserData.url.toString()),
                    radius: 60,
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    name.capitalize(),
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff49c42b),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      openDialog();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Do you want to sure logout?',
              style: TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  setStatus();
                  logout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginPage()));
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ));

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await storage.delete(key: "uid");
  }
}
