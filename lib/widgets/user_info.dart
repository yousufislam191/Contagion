import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';

class Ppage extends StatelessWidget {
  final docData;
  const Ppage({Key? key, String? title, required this.docData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String name = docData[getListData.name];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile ',
        ),
      ),
      body: Column(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                  image: const AssetImage("assets/images/LU-campus.jpg"),
                ),
                Positioned(
                    bottom: -50.0,
                    child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: docData[getListData.url] == null
                            ? CircleAvatar(
                                radius: 75,
                              )
                            : CircleAvatar(
                                radius: 75,
                                backgroundImage:
                                    NetworkImage(docData[getListData.url]),
                              )))
              ]),
          SizedBox(
            height: 45,
          ),
          ListTile(
            title: Center(
                child: Text(
              name.capitalize(),
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            )),
            subtitle: Center(
              child: Column(children: [
                Text(docData[getListData.department],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    )),
                Text(docData[getListData.identity],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    )),
                docData[getListData.batch] == null
                    ? Text('The user has not updated his profile.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ))
                    : Text(docData[getListData.batch],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        )),
                docData[getListData.section] == null
                    ? Text('The user has not updated his profile.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ))
                    : Text(docData[getListData.section],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        )),
                docData[getListData.mobile] == null
                    ? Text('The user has not updated his profile.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ))
                    : Text(docData[getListData.mobile],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        )),
              ]),
            ),
          ),
          ListTile(
            title: Center(
              child: Text('About me ',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline)),
            ),
            subtitle: docData[getListData.about] == null
                ? Text('.....',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ))
                : Text(
                    docData[getListData.about],
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Center(
                child: Text(
              'Social',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            )),
            subtitle: Row(
              children: [
                Expanded(
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                      ),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
