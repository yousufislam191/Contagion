import 'package:flutter/material.dart';

class developer extends StatelessWidget {
  late double height, width;
  // const developer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: new Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Developers'),
            centerTitle: true,
          ),
          body: Container(
            // alignment: AlignmentGeometry(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage("assets/developerImages/yousuf1.jpg"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Md. Yousuf Islam',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'JosefinSans'),
                      ),
                      Text(
                        '50\u1d57\u02b0 Batch',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
                      ),
                      Text(
                        'Computer Science and Engineering',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
                      ),
                      Text(
                        'Leading University',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.5),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  // height: height * 0.4,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage("assets/developerImages/Naima.jpeg"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Naima Akther',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'JosefinSans'),
                      ),
                      Text(
                        '50\u1d57\u02b0 Batch',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
                      ),
                      Text(
                        'Computer Science and Engineering',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
                      ),
                      Text(
                        'Leading University',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'JosefinSans'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
