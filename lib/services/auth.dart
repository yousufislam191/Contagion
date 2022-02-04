import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

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

// // for login
//   Future loginWithEmailAndPassword(String _email, String _pass) async {
//     try {
//       final newUser = await _auth.signInWithEmailAndPassword(
//           email: _email, password: _pass);
//       login_user_data(newUser);
//     } on FirebaseAuthException catch (error) {
//       switch (error.code) {
//         case "invalid-email":
//           errorMessage = "Your email address appears to be incorrect.";
//           break;
//         case "wrong-password":
//           errorMessage = "Your password is wrong.";
//           break;
//         case "user-not-found":
//           errorMessage = "User with this email doesn't exist.";
//           break;
//         case "user-disabled":
//           errorMessage = "User with this email has been disabled.";
//           break;
//         case "too-many-requests":
//           errorMessage = "Too many requests";
//           break;
//         case "operation-not-allowed":
//           errorMessage = "Signing in with Email and Password is not enabled.";
//           break;
//         default:
//           errorMessage = "An undefined Error happened.";
//       }
//       Fluttertoast.showToast(msg: errorMessage!);
//       print(error.code);
//     }
//   }
}
