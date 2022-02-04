import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';
import 'package:lu_ahatting_application/widgets/editProfile.dart';
class NavHeader extends StatelessWidget {
  const NavHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green
            ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 45.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center+Alignment(.1, -.2),
                    child: Text("Chat app",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                  Align(
                    alignment: Alignment.center+Alignment(.1,.2),
                    child: Text("1912020155",style: TextStyle(color: Colors.white70,fontSize: 17),),
                  ),
                  Align(
                    alignment: Alignment.topCenter+Alignment(1.1,.2),
                    child: IconButton(icon: new Icon(Icons.more_vert),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),

                        );
                      },)

                  )
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