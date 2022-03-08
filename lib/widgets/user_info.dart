import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/ProfileWidget.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';

class Ppage extends StatelessWidget {
  final docData;
  Ppage({Key? key, required this.docData}) : super(key: key);

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
                    backgroundColor: Colors.white,
                    child:
                        ProfileWidget(imagePath: 'assets/images/images.jpeg'),
                    radius: 50.0,
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    docData[getListData.name],
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontFamily: 'JosefinSans',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    docData[getListData.mobile],
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontFamily: 'JosefinSans',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        docData[getListData.batch],
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18,
                          fontFamily: 'JosefinSans',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        docData[getListData.section],
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18,
                          fontFamily: 'JosefinSans',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    docData[getListData.about],
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontFamily: 'JosefinSans',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
