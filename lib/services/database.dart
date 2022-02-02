import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/models/user.dart';

user_data(String name, String id, var departmentType, var identityType) async {
  String _name = name;
  String _id = id;
  String _departmentType = departmentType;
  String _identityType = identityType;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = _auth.currentUser;

  UserModel usermodel = UserModel();

  usermodel.uid = user?.uid;
  usermodel.name = _name;
  usermodel.email = user?.email;
  usermodel.id = _id;
  usermodel.department = _departmentType;
  usermodel.identity = _identityType;

  //for student
  if (_identityType == 'Student') {
    await firebaseFirestore
        .collection('Student')
        .doc(usermodel.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
  //for Teacher
  else if (_identityType == 'Teacher') {
    await firebaseFirestore
        .collection('Teacher')
        .doc(usermodel.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
  //for Dept. Head
  else if (_identityType == 'Dept. Head') {
    await firebaseFirestore
        .collection('Dept. Head')
        .doc(usermodel.uid)
        .set(usermodel.toMap());
    Fluttertoast.showToast(
        msg: "Account created successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
