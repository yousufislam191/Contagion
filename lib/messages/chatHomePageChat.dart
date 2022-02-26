import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
//   }
// }

class chatHomePageChat extends StatelessWidget {
  // final chatDocId;
  // final targetChatName;
  // final targetChatUid;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  // chatHomePageChat(
  //     {Key? key, this.chatDocId, this.targetChatName, this.targetChatUid})
  // : super(key: key);
  String targetChatName = '';

  @override
  Widget build(BuildContext context) {
    // @override
    // void initState() {
    //   super.initState();
    //   valueCheck();
    // }

    // void valueCheck() async {
    //   FirebaseFirestore.instance
    //       .collection('chats')
    //       .where('senderId', isEqualTo: currentUserId)
    //       .snapshots();
    // }

    // CollectionReference db = FirebaseFirestore.instance
    //     .collection('chats')
    //     .where('users', isEqualTo: {targetChatUid: null, currentUserId: null});
    //     stream:
    // CollectionReference db = FirebaseFirestore.instance.collection('chats');
    return StreamBuilder(
        // stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        // stream: db.where("regions", "west_coast"),

        // stream: FirebaseFirestore.instance.collection('chats').snapshots(),

        // stream: FirebaseFirestore.instance
        //     .collection('chats')
        //     .where('senderId', isEqualTo: currentUserId)
        //     .snapshots(),
        // builder: (BuildContext,
        //     AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot) {
        //   if (snapshot.hasData && snapshot.data != null) {
        //     if (snapshot.data!.docs.isNotEmpty) {
        //       print('1nd stream builder');
        //       return ListView.builder(
        //         itemCount: snapshot.data!.docs.length,
        //         itemBuilder: (BuildContext, int index) {
        //           Map<dynamic, dynamic> docData =
        //               snapshot.data!.docs[index].data();
        //           final users = docData["users"];
        //           String senderid = docData["senderId"];
        //           String receiverid = docData["receiverid"];

        //           Map matchingMap = {receiverid: null, currentUserId: null};
        //           // print('1nd stream builder');

        //           return StreamBuilder(
        //               stream: FirebaseFirestore.instance
        //                   .collection('chats')
        //                   .where('users', isEqualTo: matchingMap)
        //                   .snapshots(),
        //               builder: (BuildContext,
        //                   AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>>
        //                       snapshot) {
        //                 print('2nd stream builder 2nd');
        //                 if (snapshot.hasData && snapshot.data != null) {
        //                   if (snapshot.data!.docs.isNotEmpty) {
        //                     if (docData.isEmpty) {
        //                       return const Text(
        //                         "Document is Empty",
        //                         textAlign: TextAlign.center,
        //                       );
        //                     }
        //                     return ListView.builder(
        //                         itemCount: snapshot.data!.docs.length,
        //                         itemBuilder: (BuildContext, int index) {
        //                           Map<dynamic, dynamic> _docData =
        //                               snapshot.data!.docs[index].data();
        //                           final _users = _docData["users"];
        //                           print('2nd map data $_users');
        //                           return ListTile(
        //                             // if (senderid == currentUserId) {}
        //                             onTap: () {
        //                               // print('map: $users');
        //                               // print('senderid: $senderid');
        //                               // print('reciverid: $receiverid');
        //                               // print('currentUserId: $currentUserId');
        //                             },
        //                             // onTap: () {
        //                             //   Navigator.push(
        //                             //     context,
        //                             //     MaterialPageRoute(
        //                             //       builder: (context) => chatPage3(
        //                             //           targetChatName: targetChatName, targetChatUid: targetChatUid),
        //                             //     ),
        //                             //   );
        //                             // },
        //                             title: Row(
        //                               children: [
        //                                 CircleAvatar(
        //                                   radius: 30,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 10,
        //                                 ),
        //                                 Column(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.center,
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                   children: [
        //                                     Text(
        //                                       // targetChatName, //.capitalize(),
        //                                       'nam aise na'.capitalize(),
        //                                       style: TextStyle(
        //                                           fontFamily: 'JosefinSans',
        //                                           fontSize: 20,
        //                                           fontWeight: FontWeight.w600),
        //                                     ),
        //                                     Text(
        //                                       'Last Text',
        //                                       style: TextStyle(
        //                                         fontFamily: 'JosefinSans',
        //                                         fontSize: 18,
        //                                         color: Colors.black54,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ],
        //                             ),
        //                           );
        //                         });
        //                   } else {
        //                     return const Center(
        //                       child: Text('Document aren\'t availavle'),
        //                     );
        //                   }
        //                 } else {
        //                   return const Center(
        //                     child: Text('Getting Error'),
        //                   );
        //                 }
        //               });

        /*


        niser gula correct


        */

        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('senderId', isEqualTo: currentUserId)
            .snapshots(),
        builder: (BuildContext,
            AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext, int index) {
                  Map<dynamic, dynamic> docData =
                      snapshot.data!.docs[index].data();
                  final users = docData["users"];
                  String senderid = docData["senderId"];
                  String receiverid = docData["receiverid"];

                  Map matchingMap = {receiverid: null, currentUserId: null};
                  var db = FirebaseFirestore.instance
                      .collection('chats')
                      .where('users', isEqualTo: matchingMap)
                      .snapshots();

                  List<String> dept =
                      List.filled(11, 'null'); // declare a String type List
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

                  List<String> identity =
                      List.filled(2, 'null'); // declare a String type List
                  identity[0] = 'Student';
                  identity[1] = 'Teacher';

                  for (int i = 0; i < 11; i++) {
                    String _dept = dept[i];
                    for (int i = 0; i < 2; i++) {
                      String _identity = identity[i];

                      void value = FirebaseFirestore.instance
                          .collection(_dept)
                          .doc(_dept)
                          .collection(_identity)
                          .doc(receiverid)
                          .snapshots();

                      // targetChatName = value["identity"]; // keep the identity value
                      // _value = (value['designation']); // keep the identity value
                      // UserModel(value);
                      break;
                    }
                  }

                  // String _senderid = db["senderId"];

                  // if (currentUserId == senderid) {}

                  if (docData.isEmpty) {
                    return const Text(
                      "Document is Empty",
                      textAlign: TextAlign.center,
                    );
                  }
                  // if ((currentUserId': null') == )

                  // Map map = docData[getHomePageData.users];

                  // else if (senderid == currentUserId) {
                  return ListTile(
                    // if (senderid == currentUserId) {}
                    // onTap: () {
                    //   // print('map: $users');
                    //   // print('senderid: $senderid');
                    //   // print('reciverid: $receiverid');
                    //   // print('currentUserId: $currentUserId');
                    //   ///
                    //   // print('chat id: $chatDocId');
                    //   // print('name: $targetChatName');
                    //   // print('target uid: $targetChatUid');
                    // },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => chatPage3(
                              targetChatName: targetChatName,
                              targetChatUid: receiverid),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // targetChatName, //.capitalize(),
                              'name'.capitalize(),
                              style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Last Text',
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
                  //   }
                  //   else {
                  //     Container();
                  // }
                },
              );
            } else {
              return const Center(
                child: Text('Document aren\'t availavle'),
              );
            }
          } else {
            return const Center(
              child: Text('Getting Error'),
            );
          }
        });
  }
}
