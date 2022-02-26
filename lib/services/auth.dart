import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/models/get_user_model.dart';
import 'package:lu_ahatting_application/services/database.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  // register with email and password
  Future registerWithEmailAndPassword(
      String _email,
      String _conPass,
      String _name,
      String _id,
      var _departmentType,
      var _identityType,
      var _teacherSelectedType) async {
    String name = _name;
    String id = _id;
    var departmentType = _departmentType;
    var identityType = _identityType;
    var teacherSelectedType = _teacherSelectedType;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: _email, password: _conPass)
          .then((value) {
        user_data(name, id, departmentType, identityType, teacherSelectedType);
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      return null;
    }
  }

  //Get uid
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser)!.uid;
  }

  //Get current user
  // Future getCurrentUser() async {
  //   return await _auth.currentUser;
  // }

  // Future<void> getCurrentUserData(
  //     DocumentSnapshot<Map<String, dynamic>> value) async {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc((await _auth.currentUser)!.uid)
  //       .get()
  //       .then((value) {
  //     getCurrentUserData(value);

  //     // setState(() {
  //     //   _userName = value.data['UserName'].toString();
  //     // });
  //   });
  // }

  GetUserModel? currentData;

  void getUserData() async {
    GetUserModel userModel;

    // List<String> dept = List.filled(11, 'null'); // declare a String type List
    // dept[0] = 'BBA';
    // dept[1] = 'CSE';
    // dept[2] = 'English';
    // dept[3] = 'EEE';
    // dept[4] = 'Civil Engineering';
    // dept[5] = 'Architecture';
    // dept[6] = 'Law';
    // dept[7] = 'Islamic Studies';
    // dept[8] = 'Public Health';
    // dept[9] = 'Tourism & Hospitality Management';
    // dept[10] = 'Bangla';

    // List<String> identity =
    //     List.filled(2, 'null'); // declare a String type List
    // identity[0] = 'Student';
    // identity[1] = 'Teacher';

    // for (int i = 0; i < 11; i++) {
    //   String _dept = dept[i];
    //   for (int i = 0; i < 2; i++) {
    //     String _identity = identity[i];

    //     var value = await FirebaseFirestore.instance
    //     .collection(_dept)
    //     .doc(_dept)
    //     .collection(_identity)
    //     .doc(_auth.currentUser?.uid)
    //     .get();
    // if (value.exists) {
    //   userModel = GetUserModel(
    //     userEmail: value.get("email"),
    //     userName: value.get("name"),
    //     userid: value.get("id"),
    //   );
    //   currentData = userModel;
    //   notifyListeners();
    // }
    //     // break;
    //   }

    var value = await FirebaseFirestore.instance
        .collection("Student")
        .doc(_auth.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = GetUserModel(
        userEmail: value.get("email"),
        userName: value.get("name"),
        userid: value.get("id"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  GetUserModel? get currentUserData {
    return currentData;
  }
}
// }
