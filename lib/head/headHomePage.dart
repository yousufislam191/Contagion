import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';

class headHomePage extends StatefulWidget {
  final currentUserValue;
  const headHomePage({Key? key, this.currentUserValue}) : super(key: key);

  @override
  _headHomePageState createState() => _headHomePageState(currentUserValue);
}

class _headHomePageState extends State<headHomePage> {
  final currentUserValue;
  final searchEditingController = TextEditingController();

  _headHomePageState(this.currentUserValue);

  @override
  Widget build(BuildContext context) {
    UserModel getData = new UserModel.fromMap(currentUserValue);
    String name = getData.name.toString();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: homePage(
          length: 4,
          backgroundColor: Color(0xFFB198F3),
          backgroundImage: NetworkImage(getData.url.toString()),
          profileText: name.capitalize(),
          controller: searchEditingController,
          searchbarCursorColor: Color(0xFF7144F0),
          searchbarIconColor: Color(0xFF7144F0),
          currentUserValue: currentUserValue,
          tabs: [
            Tab(text: 'Chat'),
            Tab(text: 'Groups'),
            Tab(text: 'Anonymous'),
            Tab(text: 'Classroom')
          ],
          children: [
            chatHomePageChat(currentUserValue: currentUserValue),
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
