import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatHomeScreen.dart';
import 'package:lu_ahatting_application/messages/messagePage.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';

class studentHomePage extends StatefulWidget {
  const studentHomePage({Key? key}) : super(key: key);

  @override
  _studentHomePageState createState() => _studentHomePageState();
}

class _studentHomePageState extends State<studentHomePage> {
  final searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: homePage(
          length: 4,
          backgroundColor: Color(0xff49c42b),
          backgroundImage: AssetImage("assets/images/profileImg.jpg"),
          profileText: 'yousuf',
          controller: searchEditingController,
          searchbarCursorColor: Color(0xff49c42b),
          searchbarIconColor: Color(0xff49c42b),
          tabs: [
            Tab(
              text: 'Chat',
            ),
            Tab(
              text: 'Groups',
            ),
            Tab(text: 'Anonymous'),
            Tab(text: 'Classroom')
          ],
          // bodyImage: null,
          children: [
            chatHomePageChat(),
            Center(
              child: Text(
                  'Group chat feature is not available at this moment. \n Developers will work with this in future.'),
            ),
            Center(
              child: Text(
                  'Anonymous chat feature is not available at this moment. \n Developers will work with this in future.'),
            ),
            Center(
              child: Text(
                  'Classroom feature is not available at this moment. \n Developers will work with this in future.'),
            ),
          ],
        ),
      ),
    );
  }
}
