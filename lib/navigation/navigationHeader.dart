import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/editProfile.dart';

class NavHeader extends StatefulWidget {
  final currentUserName;
  final subTitle;
  NavHeader({Key? key, this.currentUserName, this.subTitle}) : super(key: key);

  @override
  State<NavHeader> createState() => _NavHeaderState(currentUserName, subTitle);
}

class _NavHeaderState extends State<NavHeader> {
  final currentUserName;
  final subTitle;
  _NavHeaderState(this.currentUserName, this.subTitle);

  @override
  Widget build(BuildContext context) {
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'JosefinSans'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            subTitle,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
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
