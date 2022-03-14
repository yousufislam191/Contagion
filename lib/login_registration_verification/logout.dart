import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';

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
    String about = _getCurrentUserData.about.toString();
    String depertment = _getCurrentUserData.department.toString();
    String batch = _getCurrentUserData.batch.toString();
    String section = _getCurrentUserData.section.toString();
    return Scaffold(
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
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [Colors.greenAccent, Colors.blueAccent])),
              child: Container(
            width: double.infinity,
            // height: 350.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _getCurrentUserData.url.toString() == null
                      ? CircleAvatar(
                          radius: 80.0,
                        )
                      : CircleAvatar(
                          backgroundImage:
                              NetworkImage(_getCurrentUserData.url.toString()),
                          radius: 80.0,
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    name.capitalize(),
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    depertment.capitalize(),
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  batch == null
                      ? Text('The user has not updated his profile.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ))
                      : Text(
                          batch.capitalize(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                  section == null
                      ? Text('The user has not updated his profile.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ))
                      : Text(
                          section,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                ],
              ),
            ),
          )),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "About Me:",
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  about == null
                      ? Text('The user has not updated his profile.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ))
                      : Text(
                          about,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,
            child: RaisedButton(
                onPressed: () {
                  openDialog();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.85, 0.19),
                      end: Alignment(-1.58, 0.0),
                      colors: [
                        const Color(0xff4de927),
                        const Color(0xff2ca70d)
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
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
