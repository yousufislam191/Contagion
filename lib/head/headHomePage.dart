import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/navigation/navigationHeader.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';

class headHomePage extends StatefulWidget {
  final name;
  const headHomePage({Key? key, this.name}) : super(key: key);

  @override
  _headHomePageState createState() => _headHomePageState(name);
}

class _headHomePageState extends State<headHomePage> {
  final name;
  final searchEditingController = TextEditingController();

  _headHomePageState(this.name);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: homePage(
          length: 4,
          backgroundColor: Color(0xFF7144F0),
          backgroundImage: AssetImage("assets/images/profileImg.jpg"),
          profileText: name,
          controller: searchEditingController,
          searchbarCursorColor: Color(0xFF7144F0),
          searchbarIconColor: Color(0xFF7144F0),
          currentUserName: name,
          tabs: [
            Tab(text: 'Chat'),
            Tab(text: 'Groups'),
            Tab(text: 'Anonymous'),
            Tab(text: 'Classroom')
          ],
          // bodyImage: AssetImage("assets/images/backgroundImg.png"),
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
