import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/head/headHomePage.dart';
import 'package:lu_ahatting_application/student/studentHomePage.dart';
import 'package:lu_ahatting_application/teacher/teacherHomePage.dart';

class setState extends StatefulWidget {
  const setState({Key? key}) : super(key: key);

  @override
  _setStateState createState() => _setStateState();
}

class _setStateState extends State<setState> {
  String _email = '', _pass = '', _Svalue = '', _name = '';
  var _Tvalue;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
