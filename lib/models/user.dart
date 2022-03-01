import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserModel {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  String? uid;
  String? name;
  String? email;
  String? id;
  String? department;
  String? identity;
  var designation;
  var status;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.id,
      this.department,
      this.identity,
      this.designation,
      this.status});

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
      'status': 'unavailable',
    };
  }

  //receiving data from server
  factory UserModel.fromMap(map) {
    if (map != null) {
      return UserModel(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        id: map['id'],
        department: map['department'],
        identity: map['identity'],
        designation: map['designation'],
        status: map['status'],
      );
    }
    return UserModel();
  }

  // Student Searching data
  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        email = snapshot['email'],
        name = snapshot['name'],
        id = snapshot['id'],
        department = snapshot['department'],
        identity = snapshot['identity'],
        designation = snapshot['designation'];

  UserModel.getTargetUserData(value) {}
}

class getListData {
  // getting teacher list
  static const String name = "name";
  static const String designation = "designation";
  static const String id = "id";
  static const String uid = "uid";
  static const String status = "status";
}

// class getStudentData {
//   // getting student list
//   static const String name = "name";
//   static const String id = "id";
//   static const String uid = "uid";
//   static const String status = "status";
// }
