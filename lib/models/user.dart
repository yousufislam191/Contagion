class UserModel {
  // String? uid;
  String? name;
  String? email;
  String? id;
  String? department;
  String? identity;

  UserModel(
      { //this.uid,
      this.name,
      this.email,
      this.id,
      this.department,
      this.identity});

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      // 'uid': uid,
      'name': name,
      'email': email,
      'id': id,
      'department': department,
      'identity': identity,
    };
  }

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      // uid: map['uid'],
      email: map['email'],
      name: map['name'],
      id: map['id'],
      department: map['department'],
      identity: map['identity'],
    );
  }
}
