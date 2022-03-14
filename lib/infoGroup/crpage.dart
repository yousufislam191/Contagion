import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/widgets/user_info.dart';

class crinfo extends StatefulWidget {
  final String Title;
  final currentUserValue;
  const crinfo({
    Key? key,
    required this.Title,
    this.currentUserValue,
  }) : super(key: key);

  @override
  _crinfoState createState() => _crinfoState(Title, currentUserValue);
}

class _crinfoState extends State<crinfo> {
  final String Title;
  final currentUserValue;

  _crinfoState(this.Title, this.currentUserValue);
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff49c42b),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "CR INFO",
            style: TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(Title)
                .doc(Title)
                .collection('Student')
                .where('cr', isEqualTo: true)
                .snapshots(),
            builder: (BuildContext,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext, int index) {
                        Map<String, dynamic> docData =
                            snapshot.data!.docs[index].data();

                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        String name = docData[getListData.name];
                        String uid = docData[getListData.uid];
                        String id = docData[getListData.id];
                        String status = docData[getListData.status];
                        var phone = docData[getListData.mobile];
                        var batch = docData[getListData.batch];
                        var section = docData[getListData.section];
                        var url = docData[getListData.url];

                        return currentUserId == uid
                            ? Container(height: 0)
                            : Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xff49c42b), width: 3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Center(
                                      child: Stack(
                                    alignment: AlignmentDirectional.topCenter,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional.topEnd +
                                            AlignmentDirectional(-0.1, -0.1),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        chatPage3(
                                                      targetUserValue: docData,
                                                      currentUserValue:
                                                          currentUserValue,
                                                    ),
                                                  ));
                                            },
                                            icon: Icon(
                                              Icons.chat_outlined,
                                              color: Colors.green,
                                            )),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          status == 'Online'
                                              ? InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Ppage(
                                                                  docData:
                                                                      docData),
                                                        ));
                                                  },
                                                  child: Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                                  .bottomEnd +
                                                              AlignmentDirectional(
                                                                  -0.1, -0.3),
                                                      children: [
                                                        url == null
                                                            ? CircleAvatar(
                                                                radius: 40,
                                                              )
                                                            : CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        url),
                                                                radius: 40,
                                                              ),
                                                        Container(
                                                          width: 16,
                                                          height: 16,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  shape: BoxShape
                                                                      .circle),
                                                        ),
                                                      ]),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Ppage(
                                                                  docData:
                                                                      docData),
                                                        ));
                                                  },
                                                  child: url == null
                                                      ? CircleAvatar(
                                                          radius: 40,
                                                        )
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(url),
                                                          radius: 40,
                                                        ),
                                                ),
                                          Text(
                                            name.capitalize(),
                                            style: TextStyle(
                                                fontFamily: 'JosefinSans',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            id,
                                            style: TextStyle(
                                                fontFamily: 'JosefinSans',
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            batch,
                                            style: TextStyle(
                                                fontFamily: 'JosefinSans',
                                                fontSize: 16),
                                          ),
                                          Text(
                                            section,
                                            style: TextStyle(
                                                fontFamily: 'JosefinSans',
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "Phn: $phone",
                                            style: TextStyle(
                                                fontFamily: 'JosefinSans',
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              );
                      });
                } else {
                  return const Center(
                    child: Text('CR List aren\'t availavle'),
                  );
                }
              } else {
                return const Center(
                  child: Text('Getting Error'),
                );
              }
            }),
      )),
    );
  }
}
