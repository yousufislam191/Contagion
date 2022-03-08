import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/infoGroup/studentChatList.dart';
import 'package:lu_ahatting_application/infoGroup/teacherChatList.dart';
import 'package:lu_ahatting_application/models/user.dart';

class crinfo extends StatefulWidget {
  const crinfo({
    Key? key,
  }) : super(key: key);

  @override
  _crinfoState createState() => _crinfoState();
}

class _crinfoState extends State<crinfo> {
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
            "CR INFO",
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
                          Icons.person,
                          color: Colors.black,
                        ),
                        Text("Naima", style: TextStyle(color: Colors.black)),
                        Text(
                          "1912020139",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("50(D)", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        // textStyle: TextStyle(color: Colors.black),
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(150, 120),
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
                        Text("Name", style: TextStyle(color: Colors.black)),
                        Text(
                          "ID",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("Section", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        // textStyle: TextStyle(color: Colors.black),
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(150, 120),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  // ElevatedButton(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.person,
                  //         color: Colors.black,
                  //       ),
                  //       Text("CR", style: TextStyle(color: Colors.black))
                  //     ],
                  //   ),
                  //   onPressed: null,
                  //   style: ElevatedButton.styleFrom(
                  //       side: BorderSide(width: 3, color: Color(0xff49c42b)),
                  //       fixedSize: const Size(100, 100),
                  //       primary: Colors.white,
                  //       elevation: 7,
                  //       shadowColor: Colors.black),
                  // ),
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
                        Text("Name", style: TextStyle(color: Colors.black)),
                        Text(
                          "ID",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("Section", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        // textStyle: TextStyle(color: Colors.black),
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(150, 120),
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
                        Text("Name", style: TextStyle(color: Colors.black)),
                        Text(
                          "ID",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("Section", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        // textStyle: TextStyle(color: Colors.black),
                        side: BorderSide(width: 3, color: Color(0xff49c42b)),
                        fixedSize: const Size(150, 120),
                        primary: Colors.white,
                        elevation: 7,
                        shadowColor: Colors.black),
                  ),
                  // ElevatedButton(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         Icons.report_problem,
                  //         color: Colors.black,
                  //       ),
                  //       Text("Report Box",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //           ))
                  //     ],
                  //   ),
                  //   onPressed: null,
                  //   style: ElevatedButton.styleFrom(
                  //       side: BorderSide(width: 3, color: Color(0xff49c42b)),
                  //       fixedSize: const Size(100, 100),
                  //       primary: Colors.white,
                  //       elevation: 7,
                  //       shadowColor: Colors.black),
                  // )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
