import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';

class chatHomePageChat extends StatefulWidget {
  // final currentUserName;

  chatHomePageChat({Key? key}) : super(key: key);

  @override
  State<chatHomePageChat> createState() => _chatHomePageChatState();
}

class _chatHomePageChatState extends State<chatHomePageChat> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  String targetChatName = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
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
                    String senderName = docData["senderName"];
                    String receiverid = docData["receiverId"];
                    String receiverName = docData["receiverName"];

                    if (senderid == currentUserId) {
                      return getSenderId(
                          receiverid: receiverid, receivername: receiverName);
                    }
                    if (receiverid == currentUserId) {
                      return getReceiverID(
                          senderid: senderid, sendername: senderName);
                    }
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

class getSenderId extends StatefulWidget {
  final receiverid;
  final receivername;
  const getSenderId({Key? key, this.receiverid, this.receivername})
      : super(key: key);

  @override
  State<getSenderId> createState() =>
      _getSenderIdState(receiverid, receivername);
}

class _getSenderIdState extends State<getSenderId> {
  final receiverid;
  final receivername;

  _getSenderIdState(this.receiverid, this.receivername);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chatPage3(
                targetChatName: receivername, targetChatUid: receiverid),
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
                receivername,
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
  final senderid;
  final sendername;
  const getReceiverID({Key? key, this.senderid, this.sendername})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                chatPage3(targetChatName: sendername, targetChatUid: senderid),
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
                sendername,
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
