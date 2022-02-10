import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lu_ahatting_application/widgets/editDropdown.dart';
import 'package:lu_ahatting_application/widgets/editTextfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();

  String _name = '', _id = '', _email = '', _call = '', _txt = '';

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

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor: Colors.white,
                    radius: 55,
                    child: Text(
                      "Leading",
                      style: TextStyle(fontFamily: 'JosefinSans'),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center + Alignment(.3, .3),
                    child: IconButton(
                      icon: new Icon(Icons.camera_alt_rounded),
                      color: Colors.black,
                      onPressed: () {},
                    )),
                Align(
                    alignment: Alignment.topCenter + Alignment(1, .2),
                    child: IconButton(
                      icon: new Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {},
                    ))
              ],
            ),
          ),
        ),
        Form(
          key: _formkey,
          child: Column(
            children: [
              editTextField(
                // NAME FIELD
                controller: nameController,
                autofillHints: [AutofillHints.name],
                labelText: "  Name",
                validator: (value) {},
                onChanged: (value) {
                  setState(() {
                    _name = value; //STORE INPUT VALUE _email VARIABLE
                  });
                },
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              editTextField(
                // ID FIELD
                controller: idController,
                keyboardType: TextInputType.number,
                // hintText: "1912020678",
                labelText: "  Student's or Teacher's ID",
                validator: (value) {},
                onChanged: (value) {
                  setState(() {
                    _id = value; //STORE INPUT VALUE _id VARIABLE
                  });
                },
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              editTextField(
                // EMAIL FIELD
                controller: callController,
                autofillHints: [AutofillHints.email],
                // hintText: "01*********",
                labelText: "call",
                prefixIcon: Icon(
                  Icons.call,
                  color: Color(0xff49c42b),
                ),
                validator: (value) {},
                onChanged: (value) {
                  setState(() {
                    _call = value; //STORE INPUT VALUE _email VARIABLE
                  });
                },
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
              editTextField(
                // PASSWORD FIELD
                controller: emailController,
                // hintText: "",
                labelText: "email",
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Color(0xff49c42b),
                ),
                validator: (value) {},
                onChanged: (value) {
                  setState(() {
                    _call = value; //STORE INPUT VALUE _pass VARIABLE
                  });
                },
              ),
              SizedBox(
                width: 20,
                height: 20,
              ),
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
              editTextField(
                controller: txtController,
                labelText: " Status Line",
                validator: (value) {},
                onChanged: (value) {
                  setState(() {
                    _txt = value; //STORE INPUT VALUE _pass VARIABLE
                  });
                },
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
