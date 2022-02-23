import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:lu_ahatting_application/widgets/ProfileWidget.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/widgets/editProfile.dart';
import 'package:lu_ahatting_application/Utils/user_simple_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavHeader extends StatefulWidget {
  AuthService userProvider;
  // DrawerSide({this.userProvider});
  NavHeader({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<NavHeader> createState() => _NavHeaderState();
}

class _NavHeaderState extends State<NavHeader> {
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
                    alignment: Alignment.center + Alignment(.3, -.2),
                    child: userData != null
                        ? Text(
                            userData.userName,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : Text("Chat App"),
                  ),
                  Align(
                    alignment: Alignment.center + Alignment(.3, .2),
                    child: userData != null
                        ? Text(
                            userData.userid,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : Text("1912020139"),
                  ),
                  Align(
                    alignment: Alignment.centerRight + Alignment(.1, .6),
                    child: userData != null
                        ? Text(
                            userData.userEmail,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        : Text("1912020139"),
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
// GestureDetector(
//   child: Icon(Icons.more_vert),
//   onTap: (){
//     print("hiiii");
//   },
// )