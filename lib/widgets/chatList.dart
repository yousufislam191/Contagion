import 'package:flutter/material.dart';

class chatList extends StatelessWidget {
  const chatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
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
                'Teacher List',
                style: TextStyle(fontFamily: 'JosefinSans'),
              ),
            ),
            body: Container(
              height: _height,
              width: _width,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Container(
                    height: _height * .07,
                    width: _width,
                    color: Colors.red,
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: Colors.black,
                    //     width: 8,
                    //   ),
                    //   //borderRadius: BorderRadius.circular(12),
                    // ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                        ),
                        Text('data')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
