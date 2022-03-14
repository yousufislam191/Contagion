import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/user_info.dart';

class receiverData extends StatefulWidget {
  final docData;
  final currentUserValue;
  const receiverData({Key? key, this.docData, this.currentUserValue})
      : super(key: key);

  @override
  State<receiverData> createState() =>
      _receiverDataState(docData, currentUserValue);
}

class _receiverDataState extends State<receiverData> {
  final docData;
  final currentUserValue;

  _receiverDataState(this.docData, this.currentUserValue);
  Map<String, dynamic>? receiverData;
  String name = '', status = '', url = '';

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    print(docData);
    DocumentSnapshot value = await FirebaseFirestore.instance
        .collection(docData['receiverDept'])
        .doc(docData['receiverDept'])
        .collection(docData['receiverIdentity'])
        .doc(docData['receiverId'])
        .get();
    UserModel _getCurrentUserData = new UserModel.fromMap(value);
    status = _getCurrentUserData.status;
    name = _getCurrentUserData.name.toString();
    url = _getCurrentUserData.url;
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
      'url': _getCurrentUserData.url,
    };
  }

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
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ppage(docData: receiverData),
                      ));
                },
                child: url == null
                    ? CircleAvatar(
                        radius: 30,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(url),
                        radius: 30,
                      ),
              ),
              status == 'Online'
                  ? Container(
                      width: 12,
                      height: 12,
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
