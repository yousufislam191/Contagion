import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/messages/receiverData.dart';
import 'package:lu_ahatting_application/messages/senderData.dart';
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

  @override
  Widget build(BuildContext context) {
    UserModel _getCurrentUserData = new UserModel.fromMap(currentUserValue);
    Future<void> _refresh() {
      // return Future.delayed(Duration(seconds: 2));
      return FirebaseFirestore.instance.collection('chats').doc().get();
      // return;
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      color: Color(0xff49c42b),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chats').snapshots(),
          builder: (BuildContext,
              AsyncSnapshot<QuerySnapshot<Map<dynamic, dynamic>>> snapshot) {
            //     if (!snapshot.hasData)
            // return Center(child: CircularProgressIndicator());
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext, int index) {
                      Map<dynamic, dynamic> docData =
                          snapshot.data!.docs[index].data();

                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return CircularProgressIndicator();
                      // } else
                      if (docData["senderId"] == _getCurrentUserData.uid ||
                          docData["receiverId"] == _getCurrentUserData.uid) {
                        return docData['senderId'] == _getCurrentUserData.uid
                            ? receiverData(
                                docData: docData,
                                currentUserValue: currentUserValue)
                            : senderData(
                                docData: docData,
                                currentUserValue: currentUserValue);
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
          }),
    );
  }
}
