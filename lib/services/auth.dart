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

  //login with email & password

//   Future signin_with_Email_And_Password(String _email, String _pass) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: _email, password: _pass);
//     } catch (e) {
//       // Fluttertoast.showToast(msg: error!.message);
//       print(e.toString());
//       return null;
//     }
//   }
// }

// Future<dynamic?> signin_with_Email_And_Password({
//     required String _email,
//     required String _pass,
//   }) async {
//     try {
//       return UserCredential._(
//       this,await _auth.signInWithEmailAndPassword(email: _email, password: _pass),
//     );
//     } catch(e) {
//       print(e.toString());
//       return null;
//     }
//   }