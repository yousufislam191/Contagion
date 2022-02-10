import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/models/get_user_model.dart';
import 'package:lu_ahatting_application/services/database.dart';

class AuthService with ChangeNotifier {
  // late final String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final userCollection = FirebaseFirestore.instance.collection("userData");
  // final FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();

  // register with email and password
  Future registerWithEmailAndPassword(String _email, String _conPass,
      String _name, String _id, var _departmentType, var _identityType) async {
    String name = _name;
    String id = _id;
    var departmentType = _departmentType;
    var identityType = _identityType;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: _email, password: _conPass)
          .then((value) {
        user_data(name, id, departmentType, identityType);
      });
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error.toString());
      return null;
    }
  }

  GetUserModel? currentData;

  void getUserData() async {
    GetUserModel userModel;
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
