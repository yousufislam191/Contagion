import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/developers.dart';
import 'package:lu_ahatting_application/infoGroup/infoPage.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/navigation/navigationHeader.dart';
import 'package:lu_ahatting_application/navigation/navigationItem.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:lu_ahatting_application/widgets/Ppage.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  final int length;
  final Color? backgroundColor;
  final ImageProvider<Object>? backgroundImage;
  final String profileText;
  final TextEditingController? controller;
  final Color? searchbarCursorColor;
  final Color? searchbarIconColor;
  final List<Widget> tabs;
  final List<Widget> children;
  final DocumentSnapshot currentUserValue;
  // String title = title;

  homePage(
      {Key? key,
      required this.length,
      required this.backgroundColor,
      required this.backgroundImage,
      required this.profileText,
      required this.controller,
      required this.searchbarCursorColor,
      required this.searchbarIconColor,
      required this.tabs,
      required this.children,
      required this.currentUserValue})
      : super(key: key);

  @override
  State<homePage> createState() => _homePageState(currentUserValue);
}

class _homePageState extends State<homePage> with WidgetsBindingObserver {
  final currentUserValue;
  _homePageState(this.currentUserValue);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  String subTitle = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    // await FirebaseFirestore.instance..collection('users').doc(_auth.currentUser!.uid).update({
    //   "status": status,
    // });
    // await currentUserValue.update({
    //   "status": status,
    // });
    List<String> dept = List.filled(11, 'null');
    dept[0] = 'BBA';
    dept[1] = 'CSE';
    dept[2] = 'English';
    dept[3] = 'EEE';
    dept[4] = 'Civil Engineering';
    dept[5] = 'Architecture';
    dept[6] = 'Law';
    dept[7] = 'Islamic Studies';
    dept[8] = 'Public Health';
    dept[9] = 'Tourism & Hospitality Management';
    dept[10] = 'Bangla';

    List<String> identity = List.filled(2, 'null');
    identity[0] = 'Student';
    identity[1] = 'Teacher';

    for (int i = 0; i < 11; i++) {
      String _dept = dept[i];
      for (int i = 0; i < 2; i++) {
        String _identity = identity[i];

        try {
          await FirebaseFirestore.instance
              .collection(_dept)
              .doc(_dept)
              .collection(_identity)
              .doc(currentUserId)
              .update({
            "status": status,
          });
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService userProvider = Provider.of<AuthService>(context);
    userProvider.getUserData();

    UserModel getData = new UserModel.fromMap(currentUserValue);
    String name = getData.name.toString();
    String id = getData.id.toString();
    String identity = getData.identity.toString();
    var designation = getData.designation.toString();

    if (identity == 'Student') {
      setState(() {
        subTitle = id;
      });
    } else {
      setState(() {
        subTitle = designation;
      });
    }

    return DefaultTabController(
      length: widget.length,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              NavHeader(
                currentUserName: name,
                subTitle: subTitle,
              ),
              Divider(),
              Expanded(
                  child: Column(
                children: [
                  NavItem(
                    title: "BBA",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "BBA", currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "CSE",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "CSE", currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "English",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "English", currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "EEE",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "EEE", currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "Civil Engineering",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "Civil Engineering",
                        currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "Architecture",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "Architecture",
                        currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "Law",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "Law", currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "Islamic Studies",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "Islamic Studies",
                        currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "Public Health",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "Public Health",
                        currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "Tourism & Hospitality Management",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "Tourism & Hospitality Management",
                        currentUserValue: currentUserValue),
                  ),
                  NavItem(
                    title: "Bangla",
                    icon: Icons.arrow_forward_ios,
                    widget: infoPage(
                        title: "Bangla", currentUserValue: currentUserValue),
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
            backgroundColor: widget.backgroundColor,
            elevation: 2,
            titleSpacing: 2,
            toolbarHeight: 80,
            title: Row(
              children: [
                // Drawer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ppage(),
                        ));
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: widget.backgroundImage,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  widget.profileText,
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
                tabs: widget.tabs),
          ),
        ),
        body: TabBarView(
            dragStartBehavior: DragStartBehavior.start,
            children: widget.children),
      ),
    );
  }
}
