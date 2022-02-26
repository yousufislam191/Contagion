import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class chatPage extends StatefulWidget {
  final targetChatName;
  final targetChatUid;
  const chatPage({Key? key, this.targetChatName, this.targetChatUid})
      : super(key: key);

  @override
  _chatPageState createState() => _chatPageState(targetChatName, targetChatUid);
}

class _chatPageState extends State<chatPage> {
  final _formkey = GlobalKey<FormState>();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final targetChatName;
  final targetChatUid;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  var chatDocId;
  final _message = new TextEditingController();

  _chatPageState(this.targetChatName, this.targetChatUid);

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    await chats
        .where('users', isEqualTo: {targetChatUid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;

                // chatHomePageChat(
                //     chatDocId: chatDocId,
                //     targetChatName: targetChatName,
                //     targetChatUid: targetChatUid);
              });
              // print('chat home page paise');
              print(chatDocId);
              print(targetChatName);
              print(targetChatUid);
            } else {
              await chats.add({
                'users': {currentUserId: null, targetChatUid: null},
                'senderId': currentUserId,
                'receiverid': targetChatUid
              }).then((value) => {chatDocId = value});
            }
          },
        )
        .catchError((error) {});
  }

  void sendMessage(String msg) {
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
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
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
                      Icons.arrow_back_ios_outlined,
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
                            'Jehadul Islam',
                            // widget.name.capitalize(),
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
                      // child: Container(
                      //   height: _height * .8,
                      //   color: Colors.black12,
                      //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //   child: ListView(
                      //     children: const [
                      //       _DateLable(lable: 'Yesterday'),
                      //       _MessageTile(
                      //         message: 'Hi, Lucy! How\'s your day going?',
                      //         messageDate: '12:01 PM',
                      //       ),
                      //       _MessageOwnTile(
                      //         message: 'You know how it goes...',
                      //         messageDate: '12:02 PM',
                      //       ),
                      //       _MessageTile(
                      //         message: 'Do you want Starbucks?',
                      //         messageDate: '12:02 PM',
                      //       ),
                      //       _MessageOwnTile(
                      //         message: 'Would be awesome!',
                      //         messageDate: '12:03 PM',
                      //       ),
                      //       _MessageTile(
                      //         message: 'Coming up!',
                      //         messageDate: '12:03 PM',
                      //       ),
                      //       _MessageOwnTile(
                      //         message: 'YAY!!!',
                      //         messageDate: '12:03 PM',
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      child: MessageListCore(
                        loadingBuilder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        emptyBuilder: (context) => const SizedBox.shrink(),
                        errorBuilder: (context, error) =>
                            DisplayErrorMessage(error: error),
                        messageListBuilder: (context, messages) =>
                            _MessageList(messages: messages),
                      ),
                    ),
                    const _ActionBar(),
                  ],
                ),
              ))),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: ListView.separated(
      //   itemCount: messages.length + 1,
      //   reverse: true,
      //   separatorBuilder: (context, index) {
      //     if (index == messages.length - 1) {
      //       return _DateLable(dateTime: messages[index].createdAt);
      //     }
      //     if (messages.length == 1) {
      //       return const SizedBox.shrink();
      //     } else if (index >= messages.length - 1) {
      //       return const SizedBox.shrink();
      //     } else if (index <= messages.length) {
      //       final message = messages[index];
      //       final nextMessage = messages[index + 1];
      //       if (!Jiffy(message.createdAt.toLocal())
      //           .isSame(nextMessage.createdAt.toLocal(), Units.DAY)) {
      //         return _DateLable(
      //           dateTime: message.createdAt,
      //         );
      //       } else {
      //         return const SizedBox.shrink();
      //       }
      //     } else {
      //       return const SizedBox.shrink();
      //     }
      //   },
      //   itemBuilder: (context, index) {
      //     if (index < messages.length) {
      //       final message = messages[index];
      //       // if (message.user?.id == context.currentUser?.id) {
      //       if (message.user?.id == context.currentUser?.uid) {
      //         return _MessageOwnTile(message: message);
      //       }
      //       else {
      //         return _MessageTile(message: message);
      //       }
      //     } else {
      //       return const SizedBox.shrink();
      //     }
      //   },
      // ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  //oposite message
  const _MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message.text ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message.text ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(message.createdAt.toLocal()).jm,
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
  }
}

class _ActionBar extends StatefulWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        height: _height * .07,
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
                  controller: controller,
                  cursorColor: Color(0xff49c42b),
                  // onChanged: (val) {
                  //   StreamChannel.of(context).channel.keyStroke();
                  // },
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Type something...',
                    border: InputBorder.none,
                  ),
                  // onSubmitted: (_) => _sendMessage(),
                  onSubmitted: (_) =>
                      _MessageOwnTile(message: Message(text: controller.text)),
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
                    child: InkWell(
                      splashColor: Colors.black12,
                      onTap: () {
                        // _sendMessage();
                        print('TODO: send a message'); //send dtatbase
                      },
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.send_rounded,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _MessageOwnTile extends StatelessWidget {     //jekta kaj korse
//   const _MessageOwnTile({
//     Key? key,
//     required this.message,
//   }) : super(key: key);

//   final Message message;

//   static const _borderRadius = 26.0;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(_borderRadius),
//                   bottomRight: Radius.circular(_borderRadius),
//                   bottomLeft: Radius.circular(_borderRadius),
//                 ),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
//                 child: Text(message.text ?? '',
//                     style: const TextStyle(
//                       color: Colors.white,
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Text(
//                 Jiffy(message.createdAt.toLocal()).jm,
//                 style: const TextStyle(
//                   color: Colors.black26,
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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

// class _DateLable extends StatelessWidget {
//   const _DateLable({
//     Key? key,
//     required this.lable,
//   }) : super(key: key);

//   final String lable;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 32.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
//             child: Text(
//               lable,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black26,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ActionBar extends StatefulWidget {  //action bar, jekta kaj korse
//   const _ActionBar({Key? key}) : super(key: key);

//   @override
//   __ActionBarState createState() => __ActionBarState();
// }

// class __ActionBarState extends State<_ActionBar> {
//   final TextEditingController controller = TextEditingController();

//   // Future<void> _sendMessage() async {
//   //   if (controller.text.isNotEmpty) {
//   //     StreamChannel.of(context)
//   //         .channel
//   //         .sendMessage(Message(text: controller.text));
//   //     controller.clear();
//   //     FocusScope.of(context).unfocus();
//   //   }
//   // }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       bottom: true,
//       top: false,
//       child: Container(
//         height: _height * .07,
//         child: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     width: 2,
//                     color: Theme.of(context).dividerColor,
//                   ),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.more_sharp,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.camera_enhance,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.image,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.mic,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 16.0),
//                 child: TextField(
//                   controller: controller,
//                   cursorColor: Color(0xff49c42b),
//                   // onChanged: (val) {
//                   //   StreamChannel.of(context).channel.keyStroke();
//                   // },
//                   style: TextStyle(fontSize: 16),
//                   decoration: InputDecoration(
//                     hintText: 'Type something...',
//                     border: InputBorder.none,
//                   ),
//                   // onSubmitted: (_) => _sendMessage(),
//                   onSubmitted: (_) =>
//                       _MessageOwnTile(message: Message(text: controller.text)),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 12,
//                 right: 24.0,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black12,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12.withOpacity(0.3),
//                       spreadRadius: 5,
//                       blurRadius: 24,
//                     ),
//                   ],
//                 ),
//                 child: ClipOval(
//                   child: Material(
//                     color: Color(0xff49c42b),
//                     child: InkWell(
//                       splashColor: Colors.black12,
//                       onTap: () {
//                         // _sendMessage();
//                         print('TODO: send a message'); //send dtatbase
//                       },
//                       child: SizedBox(
//                         width: 40,
//                         height: 40,
//                         child: Icon(
//                           Icons.send_rounded,
//                           size: 26,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     // return SafeArea(
//     //   bottom: true,
//     //   top: false,
//     //   child: Row(
//     //     children: [
//     //       Container(
//     //         decoration: BoxDecoration(
//     //           border: Border(
//     //             right: BorderSide(
//     //               width: 2,
//     //               color: Theme.of(context).dividerColor,
//     //             ),
//     //           ),
//     //         ),
//     //         child: const Padding(
//     //           padding: EdgeInsets.symmetric(horizontal: 16.0),
//     //           child: Icon(
//     //             CupertinoIcons.camera_fill,
//     //           ),
//     //         ),
//     //       ),
//     //       Expanded(
//     //         child: Padding(
//     //           padding: const EdgeInsets.only(left: 16.0),
//     //           child: TextField(
//     //             controller: controller,
//     //             onChanged: (val) {
//     //               StreamChannel.of(context).channel.keyStroke();
//     //             },
//     //             style: const TextStyle(fontSize: 14),
//     //             decoration: const InputDecoration(
//     //               hintText: 'Type something...',
//     //               border: InputBorder.none,
//     //             ),
//     //             onSubmitted: (_) => _sendMessage(),
//     //           ),
//     //         ),
//     //       ),
//     //       Padding(
//     //         padding: const EdgeInsets.only(
//     //           left: 12,
//     //           right: 24.0,
//     //         ),
//     //         child: GlowingActionButton(
//     //           color: AppColors.accent,
//     //           icon: Icons.send_rounded,
//     //           onPressed: _sendMessage,
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }

// class _ActionBar extends StatelessWidget {
//   const _ActionBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;
//     TextEditingController? sendingTextController;
//     return SafeArea(
//       bottom: true,
//       top: false,
//       child: Container(
//         height: _height * .07,
//         child: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     width: 2,
//                     color: Theme.of(context).dividerColor,
//                   ),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.more_sharp,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.camera_enhance,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.image,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     widthFactor: .8,
//                     child: IconButton(
//                       icon: new Icon(
//                         Icons.mic,
//                         color: Color(0xff49c42b),
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 16.0),
//                 child: TextField(
//                   controller: controller,
//                   cursorColor: Color(0xff49c42b),
//                   onChanged: (val) {
//                     StreamChannel.of(context).channel.keyStroke();
//                   },
//                   style: TextStyle(fontSize: 16),
//                   decoration: InputDecoration(
//                     hintText: 'Type something...',
//                     border: InputBorder.none,
//                   ),
//                   onSubmitted: (_) => _sendMessage(),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 12,
//                 right: 24.0,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black12,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12.withOpacity(0.3),
//                       spreadRadius: 5,
//                       blurRadius: 24,
//                     ),
//                   ],
//                 ),
//                 child: ClipOval(
//                   child: Material(
//                     color: Color(0xff49c42b),
//                     child: InkWell(
//                       splashColor: Colors.black12,
//                       onTap: () {
//                         _sendMessage,
//                         print('TODO: send a message'); //send dtatbase
//                       },
//                       child: SizedBox(
//                         width: 40,
//                         height: 40,
//                         child: Icon(
//                           Icons.send_rounded,
//                           size: 26,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class DisplayErrorMessage extends StatelessWidget {
  const DisplayErrorMessage({Key? key, this.error}) : super(key: key);

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Oh no, something went wrong. '
        'Please check your config. $error',
      ),
    );
  }
}
