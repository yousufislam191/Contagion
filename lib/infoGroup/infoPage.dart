import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/infoGroup/studentChatList.dart';
import 'package:lu_ahatting_application/infoGroup/teacherChatList.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/infoGroup/crpage.dart';

class infoPage extends StatefulWidget {
  final String title;
  final currentUserValue;
  const infoPage({
    Key? key,
    required this.title,
    this.currentUserValue,
  }) : super(key: key);

  @override
  _infoPageState createState() => _infoPageState(currentUserValue);
}

class _infoPageState extends State<infoPage> {
  final currentUserValue;
  _infoPageState(this.currentUserValue);

  String Title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff49c42b),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            '${widget.title}',
            style: TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book,
                          color: Colors.black,
                        ),
                        Text("Notice", style: TextStyle(color: Colors.black))
                      ],
                    ),
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        // textStyle: TextStyle(color: Colors.black),
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(100, 100),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  ElevatedButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people,
                          color: Colors.black,
                        ),
                        Text("Teachers", style: TextStyle(color: Colors.black))
                      ],
                    ),
                    onPressed: () async {
                      Title = '${widget.title}';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => chatList(
                                  Title: Title,
                                  currentUserValue: currentUserValue,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(100, 100),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  ElevatedButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        Text("CR", style: TextStyle(color: Colors.black))
                      ],
                    ),
                    onPressed: () {
                      Title = '${widget.title}';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => crinfo(
                                  Title: Title,
                                  currentUserValue: currentUserValue,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(100, 100),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                width: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        Text("Students", style: TextStyle(color: Colors.black))
                      ],
                    ),
                    // onPressed: null,
                    onPressed: () async {
                      Title = '${widget.title}';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => studentChatList(
                                  Title: Title,
                                  currentUserValue: currentUserValue,
                                )),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(100, 100),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  ElevatedButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pause_presentation,
                          color: Colors.black,
                        ),
                        Text("Routine", style: TextStyle(color: Colors.black))
                      ],
                    ),
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(100, 100),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  ElevatedButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.report_problem,
                          color: Colors.black,
                        ),
                        Text("Report Box",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ))
                      ],
                    ),
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(100, 100),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
