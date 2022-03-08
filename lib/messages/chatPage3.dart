import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lu_ahatting_application/encryption/encrypt_service.dart';
import 'package:lu_ahatting_application/messages/downloading_file.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

    // await FirebaseFirestore.instance

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    // var uploadTask = await ref.putFile(imageFile!);
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await chats.doc(chatDocId).collection('messages').doc(fileName).delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      // String plainImgUrl = imageUrl;
      // setState(() {
      //   encryptedImgUrl = encryptionService.encryptAES(imageUrl);
      // });

      // await chats
      //     .doc(chatDocId)
      //     .collection('messages')
      //     .get()
      //     .then((QuerySnapshot querySnapshot) {
      //   // if (querySnapshot.docs.isNotEmpty) {
      //   //   setState(() {
      //   //     chatMsgDocId = querySnapshot.docs.single.id;
      //   //   });
      //   //   print(chatMsgDocId);
      //   // } else {
      //   chats.doc(chatDocId).collection('messages').add({
      //     "msg": imageUrl,
      //     'time': FieldValue.serverTimestamp(),
      //     'uid': currentUserId,
      //     'msgid': querySnapshot.docs.single.id,
      //     "type": "img",
      //   }).then((value) => {chatMsgDocId = value.toString()});
      //   // }
      // }).catchError((error) {});

      await chats.doc(chatDocId).collection('messages').add({
        "msg": imageUrl,
        'time': FieldValue.serverTimestamp(),
        'uid': currentUserId,
        "type": "img",
      });

      print(imageUrl);
    }
  }

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

          if (snapshot.hasData) {
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
                                                      : BoxDecoration(
                                                          color:
                                                              Color(0xFF08C187),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                            : data['msg'] != ''
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
                                                                : CircularProgressIndicator(),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Text(
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
                                                    : BoxDecoration(
                                                        color:
                                                            Color(0xffE7E7ED),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                          : data['msg'] != ''
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
                                                              : CircularProgressIndicator(),
                                                    )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                  data['time']
                                                      .toDate()
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black26,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
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
                                        // onPressed: () => selectFile(),
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
                                        // onPressed: () {},
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
                            // height: MediaQuery.of(context).size.height,
                            // height: 100,
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
                            // onTap: () {
                            //   DownloadingDialog(url: img);
                            // },
                            onTap: () => downloadFile(img),
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

  downloadFile(url) async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded = await saveVideo(url, "video.jpg");
    if (downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            await _requestPermission(Permission.accessMediaLocation) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          // if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/ChatApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
        print('android');
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

  // void _requestDownload(String url) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/${url.name}')
  //   await url.writeToFile(file);
  // }
  // Future requestDownload(String url) async {
  //   // final status = await Permissions.storage.request();
  //   // if (status.isGranted) {
  //   //   final baseStorage = await getExternalStorageDirectory();
  //   // }
  //   // final name = fileName ?? url.split('/').last;
  //   // final baseStorage = await getApplicationDocumentsDirectory();
  //   // final taskId = await FlutterDownloader.enqueue(
  //   //   url: url,
  //   //   savedDir: baseStorage.path,
  //   //   // fileName: ,
  //   // );
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //     //add more permission to request here.
  //   ].request();

  //   if (statuses[Permission.storage]!.isGranted) {
  //     var dir = await DownloadsPathProvider.downloadsDirectory;
  //     if (dir != null) {
  //       String savename = "file.jpg";
  //       String savePath = dir.path + "/$savename";
  //       print(savePath);
  //       //output:  /storage/emulated/0/Download/banner.png

  //       try {
  //         await Dio().download(url, savePath,
  //             onReceiveProgress: (received, total) {
  //           if (total != -1) {
  //             print((received / total * 100).toStringAsFixed(0) + "%");
  //             Fluttertoast.showToast(msg: 'File download completed');
  //             //you can build progressbar feature too
  //           }
  //         });
  //         print("File is saved to download folder.");
  //       } on DioError catch (e) {
  //         print(e.message);
  //       }
  //     }
  //   } else {
  //     print("No permission to read and write.");
  //   }
  //   // if (taskId != null) {
  //   //   Fluttertoast.showToast(msg: 'File download completed');
  //   // }
  // }

  // ///for download image
  // Future openFile({required String url, String? fileName}) async {
  //   final name = fileName ?? url.split('/').last;
  //   final file = await downloadFile(url, name);

  //   if (file == null) return;
  //   if (file != null) {
  //     print('Path: ${file.path}');
  //     Fluttertoast.showToast(msg: 'File download completed');

  //     OpenFile.open(file.path);
  //   }
  // }

  // // Future<File?> downloadFile(String url, String name) async {
  // Future<File?> downloadFile(String url, String? fileName) async {
  //   final name = fileName ?? url.split('/').last;
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final file = File('${appStorage.path}/$name');

  //   try {
  //     final response = await Dio().get(url,
  //         options: Options(
  //             responseType: ResponseType.bytes,
  //             followRedirects: false,
  //             receiveTimeout: 0));

  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();

  //     return file;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  ///for file sharing
  // Future selectFile() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: false);

  //   if (result == null) return;
  //   final path = result.files.single.path!;

  //   setState(() => file = File(path));
  // }

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
