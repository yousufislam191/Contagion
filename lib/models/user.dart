import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserModel {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var uid;
  String? name;
  String? email;
  String? id;
  String? department;
  String? identity;
  var designation;
  var status;
  var mobile;
  var batch;
  var section;
  var about;
  bool? cr;
  String? url;
  var msg;
  String? type;
  Timestamp? time;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.id,
    this.department,
    this.identity,
    this.designation,
    this.status,
    this.mobile,
    this.batch,
    this.section,
    this.about,
    this.cr,
    this.url,
    this.msg,
    this.time,
    this.type,
  });

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
      'mobile': mobile,
      'batch': batch,
      'section': section,
      'about': about,
      'cr': cr,
      'url': url,
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
        mobile: map['mobile'],
        batch: map['batch'],
        section: map['section'],
        about: map['about'],
        cr: map['cr'],
        url: map['url'],
      );
    }
    return UserModel();
  }

  //receiving last message data from server
  factory UserModel.lastmsg(map) {
    // if (map != null) {
    if (map == null) return UserModel();
    return UserModel(
      // uid: map['uid'],
      type: map['type'],
      time: map['time'],
      msg: map['msg'],
    );
    //}
    //return UserModel();
  }

  // Student Searching data
  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot['uid'],
        email = snapshot['email'],
        name = snapshot['name'],
        id = snapshot['id'],
        department = snapshot['department'],
        identity = snapshot['identity'],
        designation = snapshot['designation'],
        mobile = snapshot['mobile'],
        batch = snapshot['batch'],
        section = snapshot['section'],
        about = snapshot['about'],
        cr = snapshot['cr'];
}

class getListData {
  // getting teacher list
  static const String name = "name";
  static const String designation = "designation";
  static const String id = "id";
  static const String uid = "uid";
  static const String department = "department";
  static const String identity = "identity";
  static const String status = "status";
  static const String mobile = "mobile";
  static const String batch = "batch";
  static const String section = "section";
  static const String about = "about";
  static const String cr = "cr";
  static const String url = "url";
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
  String mobile = value['mobile'];
  String batch = value['batch'];
  String section = value['section'];
  String about = value['about'];
  String cr = value['cr'];
  String url = value['url'];

  print(name);
  print(identity);
  currentUserData(name, identity, email, id, department, uid, mobile, batch,
      section, about, cr, url);
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
  final String mobile;
  final String batch;
  final String section;
  final String about;
  final String cr;
  final String url;

  currentUserData(
      this.name,
      this.identity,
      this.email,
      this.id,
      this.department,
      this.uid,
      this.about,
      this.batch,
      this.cr,
      this.mobile,
      this.section,
      this.url);

  // print(name);

  // String _name = name;
  // String _id = id;
  // String _email = email;
  // String _identity = identity;
  // String _department = department;

}

// class getStudentData {
//   // getting student list
//   static const String name = "name";
//   static const String id = "id";
//   static const String uid = "uid";
//   static const String status = "status";
// }

