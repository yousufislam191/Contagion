import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';

class Ppage extends StatefulWidget {
  const Ppage({Key? key}) : super(key: key);

  @override
  _PpageState createState() => _PpageState();
}

class _PpageState extends State<Ppage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: Color(0xff49c42b),
                leading: IconButton(
                  icon: new Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profileImg.jpg"),
                    radius: 60,
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text("Name"),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(
                      "LogOut",
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
            title: const Text('Are you sure?'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  logout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginPage()));
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('No'),
              ),
            ],
          ));

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
