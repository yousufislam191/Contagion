import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/widgets/editProfile.dart';

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
