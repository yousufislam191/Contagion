import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lu_ahatting_application/encryption/encrypt_service.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:uuid/uuid.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class chatPage3 extends StatefulWidget {
  final currentUserValue;
  final targetUserValue;
  const chatPage3({Key? key, this.currentUserValue, this.targetUserValue})
      : super(key: key);

  @override
  _chatPage3State createState() =>
      _chatPage3State(currentUserValue, targetUserValue);
}

class _chatPage3State extends State<chatPage3> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final currentUserValue;
  final targetUserValue;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  var chatDocId, encryptedText, decryptedText, plainText;
  String decryptedPlainText = '';
  final _message = new TextEditingController();

  _chatPage3State(this.currentUserValue, this.targetUserValue);

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    UserModel _getData = new UserModel.fromMap(currentUserValue);
    String targetChatUid = targetUserValue[getListData.uid];
    await chats
        .where('users', isEqualTo: {targetChatUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });
              print(chatDocId);
              print(targetUserValue[getListData.name]);
              print(targetChatUid);
            } else {
              await chats.add({
                'users': {currentUserId: null, targetChatUid: null},
                'senderId': currentUserId,
                'senderName': _getData.name,
                'receiverId': targetChatUid,
                'receiverName': targetUserValue[getListData.name],
              }).then((value) => {chatDocId = value.toString()});
            }
          },
        )
        .catchError((error) {});
  }

  // //get image from gallary
  // File? imageFile;
  // Future getImage() async {
  //   ImagePicker _picker = ImagePicker();

  //   await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
  //     if (xFile != null) {
  //       imageFile = File(xFile.path);
  //       uploadImage();
  //     }
  //   });
  // }

  // //upload image in server
  // Future uploadImage() async {
  //   String fileName = Uuid().v1();
  //   int status = 1;

  //   var ref =
  //       FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

  //   var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
  //     await chats.doc(chatDocId).collection('messages').doc(fileName).delete();

  //     status = 0;
  //   });

  //   if (status == 1) {
  //     String imageUrl = await uploadTask.ref.getDownloadURL();

  //     await chats.doc(chatDocId).collection('messages').doc(fileName).update({
  //       "message": imageUrl,
  //       'time': FieldValue.serverTimestamp(),
  //       'uid': currentUserId,
  //     });

  //     print(imageUrl);
  //   }
  // }

  void sendMessage(var msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'time': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': msg
    }).then((value) {
      _message.clear();
    });
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    // final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: chats
            .doc(chatDocId)
            .collection('messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     // child: Text("Loading"),
          //     child: CircularProgressIndicator(),
          //   );
          // }

          if (snapshot.hasData) {
            var data;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Lu Chatting Application',
              home: SafeArea(
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(65),
                    child: AppBar(
                      backgroundColor: Colors.white,
                      leading: IconButton(
                        icon: new Icon(
                          Icons.arrow_back,
                          color: Color(0xff49c42b),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      titleSpacing: 1,
                      toolbarHeight: 60,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    targetUserValue[getListData.name],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'JosefinSans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  targetUserValue[getListData.status] ==
                                          'Online'
                                      ? Text(
                                          'online',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'JosefinSans',
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        )
                                      : Text(
                                          'Offline',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'JosefinSans',
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment:
                                    Alignment.centerLeft, //+ Alignment(.1, .2),
                                widthFactor: .8,
                                child: IconButton(
                                  icon: new Icon(
                                    Icons.call,
                                    color: Color(0xff49c42b),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                widthFactor: .8,
                                child: IconButton(
                                  icon: new Icon(
                                    Icons.video_call,
                                    color: Color(0xff49c42b),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: new Icon(
                                    Icons.more_vert,
                                    color: Color(0xff49c42b),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            reverse: true,
                            children: snapshot.data!.docs.map(
                              (DocumentSnapshot document) {
                                data = document.data()!;
                                decryptedText = encryptionService.decryptAES(
                                    data['msg']); //Decrypted Text Here
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ChatBubble(
                                    clipper: ChatBubbleClipper6(
                                      nipSize: 1,
                                      radius: 26,
                                      type: isSender(data['uid'].toString())
                                          ? BubbleType.sendBubble
                                          : BubbleType.receiverBubble,
                                    ),
                                    alignment:
                                        getAlignment(data['uid'].toString()),
                                    margin: EdgeInsets.only(top: 20),
                                    backGroundColor:
                                        isSender(data['uid'].toString())
                                            ? Color(0xFF08C187)
                                            : Color(0xffE7E7ED),
                                    child: Container(
                                      // color: Colors.black26,
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(decryptedText,
                                                    style: TextStyle(
                                                      color: isSender(
                                                              data['uid']
                                                                  .toString())
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontFamily: 'JosefinSans',
                                                      fontSize: 16,
                                                    ),
                                                    // textAlign: TextAlignVertical.center,
                                                    maxLines: 100,
                                                    overflow:
                                                        TextOverflow.visible),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                // child: Text(
                                                //   data['time'] == null
                                                //       ? DateTime.now()
                                                //           .toString()
                                                //       : data['time']
                                                //           .toDate()
                                                //           .toString(),
                                                //   style: TextStyle(
                                                //     fontSize: 14,
                                                //     color: isSender(data['uid']
                                                //             .toString())
                                                //         ? Colors.white
                                                //         : Colors.black,
                                                //     fontFamily: 'JosefinSans',
                                                //     overflow:
                                                //         TextOverflow.visible,
                                                //   ),
                                                // ),
                                                child: Text(
                                                  data['time'] == null
                                                      ? DateTime.now()
                                                          .toString()
                                                      : data['time']
                                                          .toDate()
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: isSender(data['uid']
                                                            .toString())
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontFamily: 'JosefinSans',
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        Container(
                          ///bottom bar
                          // height: _height * .06,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: .8,
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.more_sharp,
                                          color: Color(0xff49c42b),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: .8,
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.camera_enhance,
                                          color: Color(0xff49c42b),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: .8,
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.image,
                                          color: Color(0xff49c42b),
                                        ),
                                        // onPressed: () => getImage(),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: .8,
                                      child: IconButton(
                                        icon: new Icon(
                                          Icons.mic,
                                          color: Color(0xff49c42b),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    controller: _message,
                                    maxLines: null,
                                    cursorColor: Color(0xff49c42b),
                                    cursorHeight: 25,
                                    style: TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintText: 'Type something...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  right: 24.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 24,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Material(
                                      color: Color(0xff49c42b),
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: IconButton(
                                          onPressed: () {
                                            plainText = _message.text;
                                            setState(() {
                                              encryptedText = encryptionService
                                                  .encryptAES(plainText);
                                            });
                                            sendMessage(encryptedText.base64);
                                          },
                                          icon: Icon(Icons.send_rounded,
                                              size: 26, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class _DateLable extends StatefulWidget {
  const _DateLable({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  __DateLableState createState() => __DateLableState();
}

class __DateLableState extends State<_DateLable> {
  late String dayInfo;

  @override
  void initState() {
    final createdAt = Jiffy(widget.dateTime);
    final now = DateTime.now();

    if (Jiffy(createdAt).isSame(now, Units.DAY)) {
      dayInfo = 'TODAY';
    } else if (Jiffy(createdAt)
        .isSame(now.subtract(const Duration(days: 1)), Units.DAY)) {
      dayInfo = 'YESTERDAY';
    } else if (Jiffy(createdAt).isAfter(
      now.subtract(const Duration(days: 7)),
      Units.DAY,
    )) {
      dayInfo = createdAt.EEEE;
    } else if (Jiffy(createdAt).isAfter(
      Jiffy(now).subtract(years: 1),
      Units.DAY,
    )) {
      dayInfo = createdAt.MMMd;
    } else {
      dayInfo = createdAt.MMMd;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              dayInfo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
