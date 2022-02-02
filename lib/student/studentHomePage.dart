import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';

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
            profileText: "Md. Yousuf",
            controller: searchEditingController,
            searchbarCursorColor: Color(0xff49c42b),
            searchbarIconColor: Color(0xff49c42b),
            tabs: [
              Tab(text: 'Chat'),
              Tab(text: 'Groups'),
              Tab(text: 'Anonymous'),
              Tab(text: 'Classroom')
            ],
            bodyImage: AssetImage("assets/images/backgroundImg.png")),
      ),
    );
  }
}
