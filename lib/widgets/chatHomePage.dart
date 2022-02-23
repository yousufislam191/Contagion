import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/developers.dart';
import 'package:lu_ahatting_application/infoGroup/infoPage.dart';
import 'package:lu_ahatting_application/navigation/navigationHeader.dart';
import 'package:lu_ahatting_application/navigation/navigationItem.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:provider/provider.dart';

class homePage extends StatelessWidget {
  final int length;
  final Color? backgroundColor;
  final ImageProvider<Object>? backgroundImage;
  final String profileText;
  final TextEditingController? controller;
  final Color? searchbarCursorColor;
  final Color? searchbarIconColor;
  final List<Widget> tabs;
  final List<Widget> children;
  // String title = title;

  const homePage(
      {Key? key,
      required this.length,
      required this.backgroundColor,
      required this.backgroundImage,
      required this.profileText,
      required this.controller,
      required this.searchbarCursorColor,
      required this.searchbarIconColor,
      required this.tabs,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService userProvider = Provider.of<AuthService>(context);
    userProvider.getUserData();

    return DefaultTabController(
      length: length,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              NavHeader(
                userProvider: userProvider,
              ),
              Divider(),
              Expanded(
                  child: Column(
                children: [
                  NavItem(
                    title: "BBA",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "BBA"),
                  ),
                  NavItem(
                    title: "CSE",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "CSE"),
                  ),
                  NavItem(
                    title: "English",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "English"),
                  ),
                  NavItem(
                    title: "EEE",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "EEE"),
                  ),
                  NavItem(
                    title: "Civil Engineering",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "Civil Engineering"),
                  ),
                  NavItem(
                    title: "Architecture",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "Architecture"),
                  ),
                  NavItem(
                    title: "Law",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "Law"),
                  ),
                  NavItem(
                    title: "Islamic Studies",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "Islamic Studies"),
                  ),
                  NavItem(
                    title: "Public Health",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "Public Health"),
                  ),
                  NavItem(
                    title: "Tourism & Hospitality Management",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "Tourism & Hospitality Management"),
                  ),
                  NavItem(
                    title: "Bangla",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(title: "Bangla"),
                  ),
                ],
              )),
              Container(
                alignment: Alignment.center,
                color: Colors.black12,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: TextButton(
                  child: Text(
                    'About Developers',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ButtonStyle(
                      // backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                      // padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 1, horizontal: 80)),
                      ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => developer(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            backgroundColor: backgroundColor,
            elevation: 2,
            titleSpacing: 2,
            toolbarHeight: 80,
            title: Row(
              children: [
                // Drawer(),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: backgroundImage,
                ),
                SizedBox(width: 15),
                Text(
                  profileText,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // flexibleSpace: Container(
            //   child: Form(
            //     child: Container(
            //       // SEARCH FIELD
            //       padding: EdgeInsets.symmetric(horizontal: 15),
            //       margin: EdgeInsets.only(top: 80),
            //       child: Material(
            //         borderRadius: BorderRadius.circular(50.0),
            //         child: TextFormField(
            //           controller: controller,
            //           cursorColor: searchbarCursorColor,
            //           // autofillHints: [AutofillHints.email],
            //           autocorrect: true,
            //           style: TextStyle(
            //             fontSize: 18,
            //             fontFamily: 'JosefinSans',
            //           ),
            //           decoration: InputDecoration(
            //             contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(50.0),
            //               borderSide: BorderSide.none,
            //             ),
            //             fillColor: Color(0xffe9e4e4),
            //             filled: true,
            //             hintText: "Search",
            //             hintStyle: TextStyle(
            //               color: Colors.grey[800],
            //               fontSize: 20,
            //               fontFamily: 'JosefinSans',
            //               fontStyle: FontStyle.normal,
            //             ),
            //             prefixIcon: Icon(
            //               Icons.search_rounded,
            //               color: searchbarIconColor,
            //             ),
            //           ),
            //           validator: (value) {},
            //           onChanged: (value) {},
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // actions: <Widget>[],
            bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                labelStyle: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w700,
                ),
                tabs: tabs),
          ),
        ),
        body: TabBarView(
            dragStartBehavior: DragStartBehavior.start, children: children),
      ),
    );
  }
}
