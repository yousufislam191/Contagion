import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
