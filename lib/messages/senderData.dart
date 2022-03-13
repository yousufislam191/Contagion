import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';

class senderData extends StatefulWidget {
  final docData;
  final currentUserValue;
  const senderData({Key? key, this.docData, this.currentUserValue})
      : super(key: key);

  @override
  State<senderData> createState() =>
      _senderDataState(docData, currentUserValue);
}

class _senderDataState extends State<senderData> {
  final docData;
  final currentUserValue;

  _senderDataState(this.docData, this.currentUserValue);
  Map<String, dynamic>? receiverData;
  String name = '', status = '';

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection(docData['senderDept'])
        .doc(docData['senderDept'])
        .collection(docData['senderIdentity'])
        .doc(docData['senderId'])
        .get();
    UserModel _getCurrentUserData = new UserModel.fromMap(value);
    status = _getCurrentUserData.status;
    name = _getCurrentUserData.name.toString();
    receiverData = {
      'uid': _getCurrentUserData.uid,
      'name': _getCurrentUserData.name,
      'email': _getCurrentUserData.email,
      'id': _getCurrentUserData.id,
      'department': _getCurrentUserData.department,
      'identity': _getCurrentUserData.identity,
      'designation': _getCurrentUserData.designation,
      'status': _getCurrentUserData.status,
      'mobile': _getCurrentUserData.mobile,
      'batch': _getCurrentUserData.batch,
      'section': _getCurrentUserData.section,
      'about': _getCurrentUserData.about,
      'cr': _getCurrentUserData.cr,
    };
  }

  // lastData() async {
  //   var lastData = FirebaseFirestore.instance
  //       .collection('chats')
  //       .doc('zOCVEKaj6hK1YUvLNUpl')
  //       .collection('messages')
  //       .orderBy("time", descending: true)
  //       .limit(1)
  //       .get();
  //   // UserModel _getLastMessageData = new UserModel.lastmsg(lastData);
  //   // String msg = _getLastMessageData.msg;
  //   // print('_getLastMessageData: $msg');
  //   print(lastData);
  // }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => chatPage3(
                targetUserValue: receiverData,
                currentUserValue: currentUserValue),
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
              status == 'Online'
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
                name,
                style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              // Text(
              //   '',
              //   style: TextStyle(
              //     fontFamily: 'JosefinSans',
              //     fontSize: 18,
              //     color: Colors.black54,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
