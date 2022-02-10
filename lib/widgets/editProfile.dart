import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lu_ahatting_application/Utils/user_simple_preference.dart';
// import 'package:lu_ahatting_application/widgets/bottomSheet.dart';
import 'package:lu_ahatting_application/widgets/editDropdown.dart';
import 'package:lu_ahatting_application/widgets/editTextfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:lu_ahatting_application/widgets/box_deco.dart';
import 'package:lu_ahatting_application/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();
  String line = '';
  String number = '';
  String _call = '', _txt = '';

  @override
  void initState() {
    super.initState();

    number = UserSimplePreferences.getUsername() ?? '';
    line = UserSimplePreferences.getLine() ?? '';
  }

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final callController = TextEditingController();
  final emailController = TextEditingController();
  final txtController = TextEditingController();

  var selectedType, deptselectedType;
  var _batch = ['Batch: 47', 'Batch: 48', 'Batch: 49', 'Batch: 50'];
  var _section = [
    'Section: A',
    'Section: B',
    'Section: C',
    'Section: D',
    'Section: E',
    'Section: F',
    'Section: G',
  ];

  File? image;

  @override
  Widget build(BuildContext context) {
    // AuthService userProvider = Provider.of<AuthService>(context);
    // userProvider.getUserData();
    // var userData = userProvider.currentUserData;
    return Material(
      child: Column(children: [
        AppBar(
          title: Text("Edit Profile"),
          backgroundColor: Colors.green,
        ),
        Card(
          child: Container(
            height: 200,
            color: Colors.green,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 55,
                    child: image != null
                        ? ClipOval(
                            child: Image.file(
                              image!,
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          )
                        : FlutterLogo(),
                  ),
                ),
                Align(
                    alignment: Alignment.center + Alignment(.3, .3),
                    child: IconButton(
                      icon: new Icon(Icons.camera_alt_rounded),
                      color: Colors.black,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) => Bottom_Sheet());
                      },
                    )),
                // Align(
                //     alignment: Alignment.topCenter + Alignment(1, .2),
                //     child: IconButton(
                //       icon: new Icon(Icons.edit),
                //       color: Colors.white,
                //       onPressed: () {},
                //     ))
              ],
            ),
          ),
        ),
        Form(
          key: _formkey,
          child: Column(
            children: [
              // // editTextField(
              // //   // NAME FIELD
              // //   controller: nameController,
              // //   autofillHints: [AutofillHints.name],
              // //   labelText: "  Name",
              // //   // initialValue: '$_name',
              // //   validator: (initialValue) {},
              // // ),
              // box_deco(text: "Naima"),
              // SizedBox(
              //   width: 20,
              //   height: 20,
              // ),
              // editTextField(
              //   // ID FIELD
              //   controller: idController,
              //   keyboardType: TextInputType.number,
              //   // hintText: "1912020678",
              //   labelText: "  Student's or Teacher's ID",
              //   validator: (value) {},
              //   onChanged: (value) {
              //     setState(() {
              //       _id = value; //STORE INPUT VALUE _id VARIABLE
              //     });
              //   },
              // ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: buildName(),
              ),

              // editTextField(
              //   // Call FIELD
              //   controller: callController,
              //   autofillHints: [AutofillHints.email],
              //   keyboardType: TextInputType.number,
              //   // hintText: "01*********",
              //   labelText: "call",
              //   prefixIcon: Icon(
              //     Icons.call,
              //     color: Color(0xff49c42b),
              //   ),
              //   validator: (value) {},
              //   onChanged: (value) {
              //     setState(() {
              //       _call = value; //STORE INPUT VALUE _email VARIABLE
              //     });
              //   },
              // ),

              SizedBox(
                width: 20,
                height: 20,
              ),
              // editTextField(
              //   // PASSWORD FIELD
              //   controller: emailController,
              //   // hintText: "",
              //   labelText: "email",
              //   prefixIcon: Icon(
              //     Icons.email_rounded,
              //     color: Color(0xff49c42b),
              //   ),
              //   validator: (value) {},
              //   onChanged: (value) {
              //     setState(() {
              //       _call = value; //STORE INPUT VALUE _pass VARIABLE
              //     });
              //   },
              // ),
              // SizedBox(
              //   width: 20,
              //   height: 20,
              // ),
              Editdropdown_button(
                hint_text: 'Batch',
                value: deptselectedType,
                validator: (value) =>
                    value == null ? 'Please select your department' : null,
                onChanged: (value) {
                  //print('$value'); //when I clicked then it print that value
                  setState(() {
                    deptselectedType = value;
                  });
                },
                itemtyType: _batch,
              ),
              Editdropdown_button(
                hint_text: 'Section',
                value: selectedType,
                validator: (value) =>
                    value == null ? 'Please select your identity' : null,
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
                itemtyType: _section,
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              // editTextField(
              //   maxLine: 4,
              //   controller: txtController,
              //   labelText: " Status Line",
              //   validator: (value) {},
              //   onChanged: (value) {
              //     setState(() {
              //       _txt = value; //STORE INPUT VALUE _pass VARIABLE
              //     });
              //   },
              // ),
              Padding(
                padding: EdgeInsets.all(12),
                child: buildline(),
              ),

              // SizedBox(
              //   width: 20,
              //   height: 20,
              // ),

              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: buildButton(),
              ),
              // RaisedButton(
              //   child: Text('Save'),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget Bottom_Sheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  takephoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () {
                  takephoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future takephoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
      );
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // dynamic names = AuthService().getCurrentUserData();

  // _fetch() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;
  //   final firebaseUser = await user;
  //   if (firebaseUser != null)
  //     await firebaseFirestore
  //         .collection('users')
  //         .doc(firebaseUser.uid)
  //         .get()
  //         .then((ds) {
  //       _email = ds.get('email');
  //       _id = ds.get('id');
  //       _name = ds.get('name');
  //     }).catchError((e) {
  //       print(e);
  //     });
  // }

  Widget buildName() => buildTitle(
        title: 'Mobile No.',
        child: TextFormField(
          keyboardType: TextInputType.number,
          initialValue: number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your Mobile No.',
          ),
          onChanged: (no) => setState(() => this.number = no),
        ),
      );

  Widget buildline() => buildTitle(
        title: 'About you',
        child: TextFormField(
          keyboardType: TextInputType.text,
          maxLines: 4,
          initialValue: line,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Max 4 line',
          ),
          onChanged: (line) => setState(() => this.line = line),
        ),
      );

  Widget buildTitle({
    required String title,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          const SizedBox(
            height: 8,
          ),
          child,
        ],
      );
  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        await UserSimplePreferences.setUsername(number);
        await UserSimplePreferences.setLine(line);
        // await UserSimplePreferences.setBirthday(birthday);
        // await UserSimplePreferences.setPets(pets);
      });
}
