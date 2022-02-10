import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/models/get_user_model.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:flutter/cupertino.dart';

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

  // //for student
  // if (_identityType == 'Student') {
  //   await firebaseFirestore
  //       .collection('Student')
  //       .doc(usermodel.uid)
  //       .set(usermodel.toMap());
  //   Fluttertoast.showToast(
  //       msg: "Account created successfully",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       fontSize: 16.0);
  // }
  // //for Teacher
  // else if (_identityType == 'Teacher') {
  //   await firebaseFirestore
  //       .collection('Teacher')
  //       .doc(usermodel.uid)
  //       .set(usermodel.toMap());
  //   Fluttertoast.showToast(
  //       msg: "Account created successfully",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       fontSize: 16.0);
  // }
  // //for Dept. Head
  // else if (_identityType == 'Dept. Head') {
  //   await firebaseFirestore
  //       .collection('Dept. Head')
  //       .doc(usermodel.uid)
  //       .set(usermodel.toMap());
  //   Fluttertoast.showToast(
  //       msg: "Account created successfully",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       fontSize: 16.0);
  // }

  List<String> dept = List.filled(11, 'null'); // declare a String type List
  dept[0] = 'BBA';
  dept[1] = 'CSE';
  dept[2] = 'English';
  dept[3] = 'EEE';
  dept[4] = 'Civil Engineering';
  dept[5] = 'Architecture';
  dept[6] = 'Law';
  dept[7] = 'Islamic Studies';
  dept[8] = 'Public Health';
  dept[9] = 'Tourism & Hospitality Management';
  dept[10] = 'Bangla';

  List<String> identity = List.filled(3, 'null'); // declare a String type List
  identity[0] = 'Student';
  identity[1] = 'Teacher';
  identity[2] = 'Dept. Head';

  for (int i = 0; i < 11; i++) {
    String _dept = dept[i];
    if (_departmentType == _dept) {
      for (int i = 0; i < 3; i++) {
        String _identity = identity[i];
        if (_identityType == _identity) {
          await firebaseFirestore
              .collection(_dept)
              .doc(usermodel.uid)
              .collection(_identity)
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
    }
  }

  // late GetUserModel currentData;

  // void getUserData() async {
  //   GetUserModel userModel;
  //   var value = await firebaseFirestore
  //       .collection("usersData")
  //       .doc(usermodel.uid)
  //       .get();
  //   if (value.exists) {
  //     userModel = GetUserModel(
  //       userEmail: value.get("email"),
  //       userName: value.get("name"),
  //       userid: value.get("id"),
  //     );
  //     currentData = userModel;
  //     notifyListeners();
  //   }
  // }

  // GetUserModel get currentUserData {
  //   return currentData;
  // }
}

// login_user_data(UserCredential newUser) async {
//   // const login_user_data({Key? key, required this._value}) : super(key: key);

//   String _identityValue;
//   // login_user_data({this._identityValue});

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // if login successfull then go to the if condition
//   if (newUser != null) {
//     final user = await _auth
//         .currentUser!; // when user login with their email & pass then will find the current user
//     final userID = user.uid; // get current user 'uid'

//     List<String> dept = List.filled(11, 'null'); // declare a String type List
//     dept[0] = 'BBA';
//     dept[1] = 'CSE';
//     dept[2] = 'English';
//     dept[3] = 'EEE';
//     dept[4] = 'Civil Engineering';
//     dept[5] = 'Architecture';
//     dept[6] = 'Law';
//     dept[7] = 'Islamic Studies';
//     dept[8] = 'Public Health';
//     dept[9] = 'Tourism & Hospitality Management';
//     dept[10] = 'Bangla';

//     List<String> identity =
//         List.filled(3, 'null'); // declare a String type List
//     identity[0] = 'Student';
//     identity[1] = 'Teacher';
//     identity[2] = 'Dept. Head';

//     for (int i = 0; i < 11; i++) {
//       String _dept = dept[i];
//       for (int i = 0; i < 3; i++) {
//         // we use loop for matchin collection with database
//         String _identity = identity[i]; // convert List Srting to String
//         try {
//           // when user login then it will find user identity from database & keep the identity value in '_value' variable
//           DocumentSnapshot value = await FirebaseFirestore.instance
//               .collection(_dept)
//               .doc(userID)
//               .collection(_identity)
//               .doc(userID)
//               .get();
//           _identityValue = (value['identity']); // keep the identity value

//           // void get_identity_value() {
//           //   print(_identityValue);
//           //   String getValue = _identityValue;
//           // }

//           // login_user_data({this._identityValue});

//           // var get_identity_value = new get_identity_value();
//           break;
//         } catch (e) {
//           print(e);
//         }
//       }
//     }
//   }
// }
// // class get_identity_value {
// //   // var _identityValue;

// //   login_user_data test1 = new login_user_data();

// //   login_user_data._identityValue;
// // }
