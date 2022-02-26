import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';

class teacherHomePage extends StatefulWidget {
  const teacherHomePage({Key? key}) : super(key: key);

  @override
  _teacherHomePageState createState() => _teacherHomePageState();
}

class _teacherHomePageState extends State<teacherHomePage> {
  final searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
          child: homePage(
        length: 3,
        backgroundColor: Color(0xFF186FB6),
        backgroundImage: AssetImage("assets/images/profileImg.jpg"),
        profileText: "Teacher",
        controller: searchEditingController,
        searchbarCursorColor: Color(0xFF186FB6),
        searchbarIconColor: Color(0xFF186FB6),
        tabs: [Tab(text: 'Chat'), Tab(text: 'Groups'), Tab(text: 'Classroom')],
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
        ],
      )),
    );
  }
}
