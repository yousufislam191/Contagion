import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';

class headHomePage extends StatefulWidget {
  const headHomePage({Key? key}) : super(key: key);

  @override
  _headHomePageState createState() => _headHomePageState();
}

class _headHomePageState extends State<headHomePage> {
  final searchEditingController = TextEditingController();

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
          profileText: "Head",
          controller: searchEditingController,
          searchbarCursorColor: Color(0xFF7144F0),
          searchbarIconColor: Color(0xFF7144F0),
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
