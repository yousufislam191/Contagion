import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? id;
  String? department;
  String? identity;
  var designation;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.id,
      this.department,
      this.identity,
      this.designation});

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name!.toLowerCase(), //data will saved as lowercase
      'email': email!.toLowerCase(),
      'id': id,
      'department': department,
      'identity': identity,
      'designation': designation,
    };
  }

  // receiving data from server
  // factory UserModel.fromMap(map) {
  //   return UserModel(
  //     uid: map['uid'],
  //     email: map['email'],
  //     name: map['name'],
  //     id: map['id'],
  //     department: map['department'],
  //     identity: map['identity'],
  //   );
  // }
  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        email = snapshot['email'],
        name = snapshot['name'],
        id = snapshot['id'],
        department = snapshot['department'],
        identity = snapshot['identity'],
        designation = snapshot['designation'];
}

class getData {
  // getting teacher list
  static const String name = "name";
  static const String designation = "designation";
  static const String uid = "uid";
}

class getStudentData {
  // getting student list
  static const String name = "name";
  static const String id = "id";
  static const String uid = "uid";
}

// class getHomePageData {
//   static const Map users = users{};
// }

// getCurrentUserData(DocumentSnapshot<Map<String, dynamic>> value) {
// // getCurrentUserData(DocumentSnapshot<Object?> value) {
//   // getting current user data

//   // String _userName = value.data['name'].toString();

// String name = value['name'];
// String identity = value['identity'];

//   // name:
//   // value['name'];
//   // identity:
//   // value['identity'];

// print(name);
// print(identity);
// }

// class getCurrentUserData
//   getCurrentUserData(DocumentSnapshot<Object?> value);
// () {

// }
// class getCurrentUserData {

// getCurrentUserData(this.name);

void getCurrentUserData(DocumentSnapshot<Object?> value) {
  // DocumentSnapshot<Object?>value;

  // getCurrentUserData ({required this.value});

  String name = value['name'];
  String identity = value['identity'];
  String email = value['email'];
  String id = value['id'];
  String department = value['department'];
  String uid = value['uid'];

  print(name);
  print(identity);
  currentUserData(name, identity, email, id, department, uid);
}

// // }

// void currentUserData(String name, String identity, String email, String id, String department, String uid) {
//   String currentUserName = name;
//   String currentUserIdentity = identity;
//   String currentUserEmail = email;
//   String currentUserId = id;
//   String currentUserDepartment = department;
//   String uid = uid;
//   print(currentUserName);
// }

class currentUserData {
  final String name;
  final String identity;
  final String email;
  final String id;
  final String department;
  final String uid;

  currentUserData(
      this.name, this.identity, this.email, this.id, this.department, this.uid);

  // print(name);

  // String _name = name;
  // String _id = id;
  // String _email = email;
  // String _identity = identity;
  // String _department = department;

}
