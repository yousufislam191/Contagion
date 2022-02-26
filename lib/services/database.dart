import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/models/user.dart';

user_data(String name, String id, var departmentType, var identityType,
    var teacherSelectedType) async {
  String _name = name;
  String _id = id;
  String _departmentType = departmentType;
  String _identityType = identityType;
  var _teacherSelectedType = teacherSelectedType;

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
  usermodel.designation = _teacherSelectedType;

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

  for (int i = 0; i < 11; i++) {
    String _dept = dept[i];
    if (_departmentType == _dept) {
      if (_identityType == 'Student') {
        await firebaseFirestore
            .collection(_dept)
            .doc(_dept)
            .collection('Student')
            .doc(usermodel.uid)
            .set(usermodel.toMap());

        Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      } else if (_identityType == 'Teacher') {
        await firebaseFirestore
            .collection(_dept)
            .doc(_dept)
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
