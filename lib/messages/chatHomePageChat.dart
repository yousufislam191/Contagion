import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';

class chatHomePageChat extends StatefulWidget {
  final currentUserValue;

  chatHomePageChat({Key? key, this.currentUserValue}) : super(key: key);

  @override
  State<chatHomePageChat> createState() =>
      _chatHomePageChatState(currentUserValue);
}

class _chatHomePageChatState extends State<chatHomePageChat> {
  final currentUserValue;
  _chatHomePageChatState(this.currentUserValue);
  // final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  // UserModel _getCurrentUserData = new UserModel.fromMap(currentUserValue);

  String targetChatName = '',
      receiverid = '',
      senderid = '',
      receiverName = '',
      senderStatus = '',
      senderName = '',
      gRname = '',
      gRid = '',
      gRstatus = '',
      gSRname = '',
      gSRid = '',
      gSRstatus = '';

  // Map<String, dynamic> RdocData, SdocData;
  var rRdocdata, sSdocData;

  void getReceiverData(receiverid) async {
    // UserModel _getCurrentUserData = new UserModel.fromMap(currentUserValue);
    // for(int i=0; i<docData.length; i++)
    List<String> dept = List.filled(11, 'null'); // declare a String type List
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

        var collection = FirebaseFirestore.instance
            .collection(_dept)
            .doc(_dept)
            .collection(_identity);
        var qs = await collection.where('uid', isEqualTo: receiverid).get();
        for (var snapshot in qs.docs) {
          Map<String, dynamic> RdocData = snapshot.data();
          rRdocdata = RdocData;

          gRname = RdocData[getListData.name];
          gRid = RdocData[getListData.id];
          gRstatus = RdocData[getListData.status];

          print(gRname);
          print(gRid);
          print(gRstatus);

          // if (senderid == _getCurrentUserData.uid) {
          //   getSenderId(
          //       receiverStatus: gRstatus,
          //       receiverName: gRname,
          //       receiverValue: RdocData);
          // }
          // if (receiverid == _getCurrentUserData.uid) {
          //   // pass sender user
          //   getReceiverID(
          //       sendervalue: currentUserValue,
          //       senderName: senderName,
          //       senderStatus: senderStatus);
          // }
        }
      }
    }
  }

  void getSenderData(senderid) async {
    // UserModel _getCurrentUserData = new UserModel.fromMap(currentUserValue);
    List<String> dept = List.filled(11, 'null'); // declare a String type List
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

        var collection = FirebaseFirestore.instance
            .collection(_dept)
            .doc(_dept)
            .collection(_identity);
        var qs = await collection.where('uid', isEqualTo: senderid).get();
        for (var snapshot in qs.docs) {
          Map<String, dynamic> SdocData = snapshot.data();
          sSdocData = SdocData;

          gSRname = SdocData[getListData.name];
          gSRid = SdocData[getListData.id];
          gSRstatus = SdocData[getListData.status];

          print(gSRname);
          print(gSRid);
          print(gSRstatus);

          // if (senderid == _getCurrentUserData.uid) {
          //   getSenderId(
          //       receiverStatus: gRstatus,
          //       receiverName: gRname,
          //       receiverValue: RdocData);
          // }
          // if (receiverid == _getCurrentUserData.uid) {
          //   // pass sender user
          //   getReceiverID(
          //       sendervalue: currentUserValue,
          //       senderName: senderName,
          //       senderStatus: senderStatus);
          // }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel _getCurrentUserData = new UserModel.fromMap(currentUserValue);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            // .orderBy('time', descending: true)
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

                    // final users = docData["users"];
                    senderid = docData["senderId"];
                    // String senderName = docData["senderName"];
                    receiverid = docData["receiverId"];
                    receiverName = docData["receiverName"];

                    // print('receiverid: $receiverid');

                    senderName = _getCurrentUserData.name.toString();
                    senderStatus = _getCurrentUserData.status;

                    // print(senderName);
                    // print(senderStatus);

                    // getReceiverData(receiverid);
                    // getSenderData(senderid);

                    if (senderid == _getCurrentUserData.uid) {
                      // List<String> dept =
                      //     List.filled(11, 'null'); // declare a String type List
                      // dept[0] = 'BBA';
                      // dept[1] = 'CSE';
                      // dept[2] = 'English';
                      // dept[3] = 'EEE';
                      // dept[4] = 'Civil Engineering';
                      // dept[5] = 'Architecture';
                      // dept[6] = 'Law';
                      // dept[7] = 'Islamic Studies';
                      // dept[8] = 'Public Health';
                      // dept[9] = 'Tourism & Hospitality Management';
                      // dept[10] = 'Bangla';

                      // List<String> identity = List.filled(2, 'null');
                      // identity[0] = 'Student';
                      // identity[1] = 'Teacher';

                      // for (int i = 0; i < 11; i++) {
                      //   String _dept = dept[i];
                      //   for (int i = 0; i < 2; i++) {
                      //     String _identity = identity[i];

                      //     StreamBuilder(
                      //         stream: FirebaseFirestore.instance
                      //             .collection(_dept)
                      //             .doc(_dept)
                      //             .collection(_identity)
                      //             .where('uid', isEqualTo: receiverid)
                      //             .snapshots(),
                      //         builder: (BuildContext,
                      //             AsyncSnapshot<
                      //                     QuerySnapshot<Map<dynamic, dynamic>>>
                      //                 snapshot) {
                      //           if (snapshot.hasData && snapshot.data != null) {
                      //             if (snapshot.data!.docs.isNotEmpty) {
                      //               return ListView.builder(
                      //                   itemCount: snapshot.data!.docs.length,
                      //                   itemBuilder: (BuildContext, int index) {
                      //                     Map<dynamic, dynamic> docData =
                      //                         snapshot.data!.docs[index].data();
                      //                     print(docData);
                      //                     // return getSenderId(
                      //                     //     receiverStatus: docData["status"],
                      //                     //     receiverName: docData["name"],
                      //                     //     receiverValue: docData);
                      //                     return Container();
                      //                   });
                      //             } else {
                      //               return const Center(
                      //                 child: Text('Document aren\'t availavle'),
                      //               );
                      //             }
                      //           } else {
                      //             return const Center(
                      //               child: Text('Getting Error'),
                      //             );
                      //           }
                      //         });
                      //     // }
                      //   }
                      // }

                      getReceiverData(receiverid);
                      return getSenderId(
                          receiverStatus: gRstatus,
                          receiverName: gRname,
                          receiverValue: rRdocdata);
                    }
                    // if (receiverid == _getCurrentUserData.uid) {
                    //   // pass sender user
                    //   getSenderData(senderid);
                    //   return getReceiverID(
                    //       sendervalue: sSdocData,
                    //       senderName: gSRname,
                    //       senderStatus: gSRstatus);
                    // }
                    return Container();
                  });
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

class getSenderId extends StatelessWidget {
  final receiverName;
  final receiverStatus;
  final receiverValue;
  const getSenderId(
      {Key? key, this.receiverName, this.receiverStatus, this.receiverValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chatPage3(targetUserValue: receiverValue),
          ),
        );
      },
      title: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd +
                AlignmentDirectional(-0.1, -0.3),
            children: [
              CircleAvatar(
                radius: 30,
              ),
              receiverStatus == 'Online'
                  ? Container(
                      width: 12,
                      height: 12,
                      // alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                receiverName,
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
  }
}

class getReceiverID extends StatelessWidget {
  final sendervalue;
  final senderName;
  final senderStatus;
  const getReceiverID(
      {Key? key, this.sendervalue, this.senderName, this.senderStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chatPage3(targetUserValue: sendervalue),
          ),
        );
      },
      title: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd +
                AlignmentDirectional(-0.1, -0.3),
            children: [
              CircleAvatar(
                radius: 30,
              ),
              senderStatus == 'Online'
                  ? Container(
                      width: 12,
                      height: 12,
                      // alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                senderName,
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
  }
}

// List<String> dept = List.filled(11, 'null'); // declare a String type List
//     dept[0] = 'BBA';
//     dept[1] = 'CSE';
//     dept[2] = 'English';
//     dept[3] = 'EEE';
//     dept[4] = 'Civil Engineering';
//     dept[5] = 'Architecture';
//     dept[6] = 'Law';
//     dept[7] = 'Islamic Studies';
//     dept[8] = 'Public Health';
//     dept[9] = 'Tourism & Hospitality Management';
//     dept[10] = 'Bangla';

//     List<String> identity = List.filled(2, 'null');
//     identity[0] = 'Student';
//     identity[1] = 'Teacher';

//     for(int i = 0; i < 11; i++) {
//       String _dept = dept[i];
//       for (int i = 0; i < 2; i++) {
//         String _identity = identity[i];

//         var collection = FirebaseFirestore.instance.collection(_dept).doc(_dept).collection(_identity);
//         var qs = await collection.where('uid', isEqualTo: receiveruid).get();
//         for(var snapshot in qs.docs) {
//           Map<String, dynamic> docData = snapshot.data();

//           String name = docData[getListData.name];
//           String id = docData[getListData.id];
//           String status = docData[getListData.status];

//           print(name);
//           print(id);
//           print(status);

//         }
//       }
//     }
