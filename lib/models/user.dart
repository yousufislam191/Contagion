import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  var url;
  var msg;
  var type;
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
        cr = snapshot['cr'],
        url = snapshot['url'];
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
