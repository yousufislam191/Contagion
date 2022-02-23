import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
//   }
// }

class chatPage2 extends StatelessWidget {
  final String name;
  final String uid;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  chatPage2({Key? key, required this.name, required this.uid})
      : super(key: key);

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//get image from gallary
  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  //upload image in server
  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    await _firestore
        .collection('chatroom')
        .doc(name)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": _auth.currentUser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('chatroom')
          .doc(name)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('chatroom')
          .doc(name)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(name)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
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
                          Text(
                            'chat name',
                            // name.capitalize(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: size.height / 1.25,
                              width: size.width,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('chatroom')
                                    .doc(name)
                                    .collection('chats')
                                    .orderBy("time", descending: false)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.data != null) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> map =
                                            snapshot.data!.docs[index].data()
                                                as Map<String, dynamic>;
                                        return messages(size, map, context);
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      ///bottom bar
                      height: _height * .06,
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
                                    onPressed: () => getImage(),
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
                                controller: _message,
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
                                      onPressed: onSendMessage,
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
              ))),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sendby'] == _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // color: Colors.blue,
                color: Color(0xff29C074),
              ),
              child: Text(
                map['message'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == _auth.currentUser!.displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(border: Border.all()),
                alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
