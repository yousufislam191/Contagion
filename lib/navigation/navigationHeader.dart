import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:lu_ahatting_application/widgets/ProfileWidget.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/widgets/editProfile.dart';
import 'package:lu_ahatting_application/Utils/user_simple_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavHeader extends StatefulWidget {
  final currentUserName;
  NavHeader({Key? key, this.currentUserName}) : super(key: key);

  @override
  State<NavHeader> createState() => _NavHeaderState(currentUserName);
}

class _NavHeaderState extends State<NavHeader> {
  final currentUserName;

  _NavHeaderState(this.currentUserName);
  @override
  Widget build(BuildContext context) {
    final user1 = UserSimplePreferences.getUser1();
    var userData = widget.userProvider.currentUserData;
    return Material(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Stack(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: FlutterLogo(),
                        radius: 45.0,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentUserName,

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ProfileWidget(imagePath: user1.imagePath),
                      radius: 45.0,
                    ),
                    // child: ProfileWidget(imagePath: user1.imagePath),
                  ),
                  Align(
                    alignment: Alignment.center + Alignment(.2, -.2),
                    child: userData != null
                        ? Text(
                            userData.userName,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : Text(
                            "Chat app",
                            // widget.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'JosefinSans'),
                          ),
                          Text(
                            "1912020139",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'JosefinSans'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.topCenter + Alignment(1.1, .2),
                      child: IconButton(
                        icon: new Icon(Icons.more_vert),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()),
                          );
                        },
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
