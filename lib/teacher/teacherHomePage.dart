import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/messages/chatHomePageChat.dart';

class teacherHomePage extends StatefulWidget {
  final currentUserValue;
  const teacherHomePage({Key? key, this.currentUserValue}) : super(key: key);

  @override
  _teacherHomePageState createState() =>
      _teacherHomePageState(currentUserValue);
}

class _teacherHomePageState extends State<teacherHomePage> {
  final currentUserValue;
  final searchEditingController = TextEditingController();

  _teacherHomePageState(this.currentUserValue);

  @override
  Widget build(BuildContext context) {
    UserModel getData = new UserModel.fromMap(currentUserValue);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
          child: homePage(
        length: 3,
        backgroundColor: Color(0xFF186FB6),
        backgroundImage: AssetImage("assets/images/profileImg.jpg"),
        profileText: getData.name.toString(),
        controller: searchEditingController,
        searchbarCursorColor: Color(0xFF186FB6),
        searchbarIconColor: Color(0xFF186FB6),
        currentUserValue: currentUserValue,
        tabs: [
          Tab(text: 'Chat'),
          Tab(text: 'Groups'),
          Tab(text: 'Classroom'),
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
        ],
      )),
    );
  }
}
