import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/widgets/editProfile.dart';

class NavHeader extends StatefulWidget {
  AuthService userProvider;
  // DrawerSide({this.userProvider});
  NavHeader({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<NavHeader> createState() => _NavHeaderState();
}

class _NavHeaderState extends State<NavHeader> {
  // @override
  // void initState() {
  // super.initState();
//    void currentUserData(String name, String identity, String email, String id, String department) {
//   String currentUserName = name;
//   String currentUserIdentity = identity;
//   String currentUserEmail = email;
//   String currentUserId = id;
//   String currentUserDepartment = department;
//   print(currentUserName);
// }
  // }

  // getCurrentUserData userData = getCurrentUserData();
  // currentUserData userData = currentUserData();
  // currentUserData? getData;

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUserData();
  // }

  @override
  Widget build(BuildContext context) {
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
                      child: FlutterLogo(),
                      radius: 45.0,
                    ),
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
                  ),
                  Align(
                      alignment: Alignment.center + Alignment(.2, .2),
                      child: userData != null
                          ? Text(
                              userData.userid,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          : Text(
                              "1912020139",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'JosefinSans'),
                            )),
                  Align(
                    alignment: Alignment.center + Alignment(.2, .6),
                    child: userData != null
                        ? Text(
                            userData.userEmail,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        : Text(
                            "1912020139",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'JosefinSans'),
                          ),
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