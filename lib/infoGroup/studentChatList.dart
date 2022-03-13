import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/infoGroup/studentSearchScreen.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/user_info.dart';

class studentChatList extends StatelessWidget {
  final String Title;
  final currentUserValue;
  studentChatList({Key? key, required this.Title, this.currentUserValue})
      : super(key: key);

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
                'Student List',
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => studentSearchScreen(Title: Title),
                      ),
                    );
                  },
                )
              ],
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(Title)
                    .doc(Title)
                    .collection('Student')
                    .snapshots(),
                builder: (BuildContext,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext, int index) {
                          Map<String, dynamic> docData =
                              snapshot.data!.docs[index].data();

                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          String name = docData[getListData.name];
                          String uid = docData[getListData.uid];
                          String id = docData[getListData.id];
                          var url = docData[getListData.url];
                          return currentUserId == uid
                              ? Container(height: 0)
                              : ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => chatPage3(
                                          targetUserValue: docData,
                                          currentUserValue: currentUserValue,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Ppage(docData: docData),
                                              ));
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(url),
                                          radius: 30,
                                        ),
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
                                            id,
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
