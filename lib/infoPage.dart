import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/widgets/chatList.dart';

class infoPage extends StatefulWidget {
  final String title;
  const infoPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _infoPageState createState() => _infoPageState();
}

class _infoPageState extends State<infoPage> {
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
            style: TextStyle(fontFamily: 'JosefinSans'),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => chatList()),
                      );
                    },
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
                          Icons.person,
                          color: Colors.black,
                        ),
                        Text("CR", style: TextStyle(color: Colors.black))
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
                    onPressed: null,
                    child: Text('Students'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Disabled Button'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Disabled Button'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
