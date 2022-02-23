import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';

class chatList extends StatelessWidget {
  final String Title;
  chatList({Key? key, required this.Title}) : super(key: key);

  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lu Chatting Application',
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff49c42b),
              leading: IconButton(
                icon: new Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Teacher List',
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(
              //       Icons.search,
              //       color: Colors.white,
              //     ),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) =>
              //               searchScreen(teacher: 'teacher', Title: Title),
              //         ),
              //       );
              //     },
              //   )
              // ],
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(Title)
                    .doc(Title)
                    .collection('Teacher')
                    .snapshots(),
                builder: (BuildContext,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // print("Total documents: ${snapshot.data!.docs.length}");
                    if (snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext, int index) {
                          Map<String, dynamic> docData =
                              snapshot.data!.docs[index].data();

                          if (docData.isEmpty) {
                            return const Text(
                              "Document is Empty",
                              textAlign: TextAlign.center,
                            );
                          }

                          String name = docData[getData.name];
                          String uid = docData[getData.uid];
                          String designation = docData[getData.designation];
                          // print(name);
                          // print(uid);
                          // print(designation);
                          return currentUserId == uid
                              ? Container(height: 0)
                              : ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => chatPage3(
                                            targetChatName: name,
                                            targetChatUid: uid),
                                      ),
                                    );
                                  },
                                  title: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name.capitalize(),
                                            style: TextStyle(
                                                fontFamily: 'JosefinSans',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            designation,
                                            style: TextStyle(
                                              fontFamily: 'JosefinSans',
                                              fontSize: 18,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                        },
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Image.asset('assets/images/backgroundImg.png'),
                          // child: Text('eita run hoitase'),
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text('Getting Error'),
                    );
                  }
                }),
          ),
        ));
  }
}
