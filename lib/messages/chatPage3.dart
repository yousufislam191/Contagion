import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lu_ahatting_application/encryption/encrypt_service.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/user_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

  File? file;

  var chatDocId,
      chatMsgDocId,
      encryptedText,
      decryptedText,
      plainText,
      encryptedImgUrl;
  String decryptedPlainText = '';
  final _message = new TextEditingController();

  _chatPage3State(this.currentUserValue, this.targetUserValue);

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  /// Two user room create in database
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
                'senderDept': _getData.department,
                'senderIdentity': _getData.identity,
                'receiverId': targetChatUid,
                'receiverName': targetUserValue[getListData.name],
                'receiverDept': targetUserValue[getListData.department],
                'receiverIdentity': targetUserValue[getListData.identity],
              }).then((value) => {chatDocId = value.toString()});
            }
          },
        )
        .catchError((error) {});
  }

  /*
  
  FOR DELETE MESSAGES
  
  */
  void sendMessage(var msg) {
    if (msg == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'time': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': msg,
      "type": "text",
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
    var UIfilename;
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

          if (snapshot.hasData) {
            String name = targetUserValue[getListData.name];
            var url = targetUserValue[getListData.url];
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
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Ppage(docData: targetUserValue),
                                      ));
                                },
                                child: url == null
                                    ? CircleAvatar(
                                        radius: 25,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(url),
                                        radius: 25,
                                      ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name.capitalize(),
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
                                alignment: Alignment.centerLeft,
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
                          child: ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext, int index) {
                                var data = snapshot.data!.docs[index];
                                var currentText = data['msg'];

                                var url_token = currentText.split('?');
                                var imageUrl = url_token[0].split('/');
                                UIfilename = imageUrl[imageUrl.length - 1]
                                    .replaceAll("%2F", "/");

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Align(
                                    alignment:
                                        getAlignment(data['uid'].toString()),
                                    child: isSender(data['uid'].toString())
                                        ? GestureDetector(
                                            onLongPress: () =>
                                                openDialog(currentText),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                  ),
                                                  decoration: data['type'] ==
                                                          'text'
                                                      ? BoxDecoration(
                                                          color:
                                                              Color(0xFF08C187),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    26),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    26),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    26),
                                                          ),
                                                        )
                                                      : data['type'] == 'img'
                                                          ? BoxDecoration(
                                                              color: Color(
                                                                  0xFF08C187),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            )
                                                          : BoxDecoration(
                                                              color: Color(
                                                                  0xFF08C187),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12.0,
                                                          vertical: 14),
                                                      child: Flexible(
                                                        child: data['type'] ==
                                                                'text'
                                                            ? Text(
                                                                decryptedText =
                                                                    encryptionService
                                                                        .decryptAES(data[
                                                                            'msg']), //Decrypted Text Here
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'JosefinSans',
                                                                  fontSize: 16,
                                                                ),
                                                                maxLines: 100,
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible)
                                                            : data['type'] ==
                                                                    'img'
                                                                ? GestureDetector(
                                                                    onTap: () =>
                                                                        expandedImg(
                                                                            currentText),
                                                                    child: Image
                                                                        .network(
                                                                      data[
                                                                          'msg'],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  )
                                                                : GestureDetector(
                                                                    onDoubleTap: () =>
                                                                        fileDialog(
                                                                            currentText),
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Text(
                                                                        UIfilename,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontFamily:
                                                                              'JosefinSans',
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: data['time'] == null
                                                      ? Container()
                                                      : Text(
                                                          data['time']
                                                              .toDate()
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black26,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.7,
                                                ),
                                                decoration: data['type'] ==
                                                        'text'
                                                    ? BoxDecoration(
                                                        color:
                                                            Color(0xffE7E7ED),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  26),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  26),
                                                          topRight:
                                                              Radius.circular(
                                                                  26),
                                                        ),
                                                      )
                                                    : data['type'] == 'img'
                                                        ? BoxDecoration(
                                                            color: Color(
                                                                0xffE7E7ED),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          )
                                                        : BoxDecoration(
                                                            color: Color(
                                                                0xffE7E7ED),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 14),
                                                    child: Flexible(
                                                      child: data['type'] ==
                                                              'text'
                                                          ? Text(
                                                              decryptedText =
                                                                  encryptionService
                                                                      .decryptAES(
                                                                          data[
                                                                              'msg']), //Decrypted Text Here
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'JosefinSans',
                                                                fontSize: 16,
                                                              ),
                                                              maxLines: 100,
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible)
                                                          : data['type'] ==
                                                                  'img'
                                                              ? GestureDetector(
                                                                  onTap: () =>
                                                                      expandedImg(
                                                                          data[
                                                                              'msg']),
                                                                  child: Image
                                                                      .network(
                                                                    data['msg'],
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                )
                                                              : GestureDetector(
                                                                  onDoubleTap: () =>
                                                                      fileDialog(
                                                                          currentText),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      UIfilename,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            'JosefinSans',
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: data['time'] == null
                                                    ? Container()
                                                    : Text(
                                                        data['time']
                                                            .toDate()
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black26,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                              )
                                            ],
                                          ),
                                  ),
                                );
                              }),
                        ),
                        Container(
                          ///bottom bar
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
                                        onPressed: () => selectFile(),
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
                                    keyboardType: TextInputType.multiline,
                                    controller: _message,
                                    maxLines: 5,
                                    minLines: 1,
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

  /*
  
  FOR DOWNLOAD ANY FILE
  
  */

  downloadFile(url, String? fileName) async {
    print(fileName);
    setState(() {
      loading = true;
      progress = 0;
    });

    var url_token = url.split('?');
    var imageUrl = url_token[0].split('/');
    var filePath = imageUrl[imageUrl.length - 1].replaceAll("%2F", "/");
    // print('Split path: $filePath');

    bool downloaded = await saveVideo(url, filePath);
    if (downloaded) {
      Fluttertoast.showToast(msg: 'File download completed');
      // print("File download completed");
    } else {
      Fluttertoast.showToast(msg: 'Problem Downloading File');
      // print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            await _requestPermission(Permission.accessMediaLocation) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          // print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Contagion";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.storage)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
        // print('android');
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  /*
  
  FOR IMAGES
  
  */
  //get image from gallary
  File? imageFile;
  String imageFileName = '';
  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        // print('Image file path: $imageFile');
        imageFileName = imageFile!.path.split('/').last;
        // print('Image file path with extention: $imageFileName');
        uploadImage();
      }
    });
  }

  //upload image in server
  Future uploadImage() async {
    int status = 1;
    var ref =
        FirebaseStorage.instance.ref().child('images').child(imageFileName);

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await chats
          .doc(chatDocId)
          .collection('messages')
          .doc(imageFileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      // print('download path: $imageUrl');

      var url_token = imageUrl.split('?');
      var url = url_token[0].split('/');
      var filePath = url[url.length - 1].replaceAll("%2F", "/");
      // print('Split path: $filePath');

      await chats.doc(chatDocId).collection('messages').add({
        "msg": imageUrl,
        'time': FieldValue.serverTimestamp(),
        'uid': currentUserId,
        "type": "img",
      });
    }
  }

  ///for expand image
  Future expandedImg(img) => showDialog(
      context: context,
      builder: (BuildContext context) => Container(
            child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: new Icon(
                      Icons.arrow_back_outlined,
                      color: Color(0xff49c42b),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              body: loading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        minHeight: 10,
                        value: progress,
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                            child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(img),
                              ),
                            ),
                          ),
                        )),
                        Container(
                          child: GestureDetector(
                            onTap: () async {
                              final filename = img.split('/').last;
                              // print(filename);
                              downloadFile(img, filename);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Color(0xff49c42b),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Save',
                                  style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
            ),
          ));

  /*
  
  FOR FILES
  
  */
  ///for file sharing
  File? documentFile;
  String? documentFileName;
  Future selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    // List<File> files = result.paths.map((path) => File(path!)).toList(); // for multiple file select
    final path = result.files.single.path!; //for single file

    setState(() => documentFile = File(path));
    // print(documentFile);

    documentFileName = documentFile!.path.split('/').last;
    uploadFile();
  }

  //upload file in server
  Future uploadFile() async {
    int status = 1;
    var ref =
        FirebaseStorage.instance.ref().child('files').child(documentFileName!);

    var uploadTask = await ref.putFile(documentFile!).catchError((error) async {
      await chats
          .doc(chatDocId)
          .collection('messages')
          .doc(documentFileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String documentFileUrl = await uploadTask.ref.getDownloadURL();

      var url_token = documentFileUrl.split('?');
      var url = url_token[0].split('/');
      var filePath = url[url.length - 1].replaceAll("%2F", "/");

      await chats.doc(chatDocId).collection('messages').add({
        "msg": documentFileUrl,
        'time': FieldValue.serverTimestamp(),
        'uid': currentUserId,
        "type": "doc",
      });
    }
  }

  Future fileDialog(currentText) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Are you sure to download this file?',
              style: TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  var url_token = currentText.split('?');
                  var imageUrl = url_token[0].split('/');
                  var UIfilename =
                      imageUrl[imageUrl.length - 1].replaceAll("%2F", "/");
                  downloadFile(currentText, UIfilename);
                  Navigator.pop(context, false);
                  Fluttertoast.showToast(msg: 'Wait for the file to download.');
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ));

  /*
  
  FOR DELETE MESSAGES
  
  */
  ///for delete message
  Future openDialog(currentText) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Message will remove from both',
              style: TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  print(currentText);
                  deleteMessage(currentText);
                  Navigator.pop(context, false);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ));
  deleteMessage(var msg) {
    if (msg == '') return;
    chats
        .doc(chatDocId)
        .collection('messages')
        .where('msg', isEqualTo: msg)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        Fluttertoast.showToast(msg: 'Document has been deleted.');
      }
    });
  }
}
