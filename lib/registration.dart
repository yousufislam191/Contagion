import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:lu_ahatting_application/loginPage.dart';
import 'package:lu_ahatting_application/services/auth.dart';
import 'package:lu_ahatting_application/widgets/regiDropdownButton.dart';
import 'package:lu_ahatting_application/widgets/elevatedButton.dart';
import 'package:lu_ahatting_application/widgets/regiTxtField.dart';
import 'package:lu_ahatting_application/widgets/txtButton.dart';
import 'package:regexed_validator/regexed_validator.dart';

class registration extends StatefulWidget {
  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  String _name = '', _id = '', _email = '', _pass = '', _conPass = '';
  RegExp emailvalidation = RegExp(r"^[a-z0-9_]+@lus.ac.bd$");
  RegExp idvalidation = RegExp(r"^[0-9]+");
  RegExp namevalidation = RegExp(r"^[a-zA-Z.]+");

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var selectedType, deptselectedType;
  var _identityType = ['Student', 'Teacher', 'Dept. Head'];
  var _departmentType = [
    'BBA',
    'CSE',
    'English',
    'EEE',
    'Civil Engineering',
    'Architecture',
    'Law',
    'Islamic Studies',
    'Public Health',
    'Tourism & Hospitality Management',
    'Bangla'
  ];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              height: _height,
              width: _width,
              child: Stack(
                children: <Widget>[
                  //DESIGN
                  Pinned.fromPins(
                    //big circle
                    Pin(start: -137.0, end: 52.0),
                    Pin(size: 513.0, start: -352.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        gradient: LinearGradient(
                          begin: Alignment(0.3, -0.84),
                          end: Alignment(-0.69, 1.45),
                          colors: [
                            const Color(0xff49c42b),
                            const Color(0xff20bf55)
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    //right circle
                    Pin(size: 223.0, end: -9.0),
                    Pin(size: 223.0, start: -95.0),
                    child: BlendMask(
                      blendMode: BlendMode.multiply,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.elliptical(9999.0, 9999.0)),
                          gradient: LinearGradient(
                            begin: Alignment(0.4, -0.8),
                            end: Alignment(0.25, 1.31),
                            colors: [
                              const Color(0xff49c42b),
                              const Color(0xff20bf55)
                            ],
                            stops: [0.0, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    //overlap circle
                    Pin(size: 323.0, start: -42.0),
                    Pin(size: 323.0, start: -248.0),
                    child: BlendMask(
                      blendMode: BlendMode.multiply,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.elliptical(9999.0, 9999.0)),
                          gradient: LinearGradient(
                            begin: Alignment(0.07, 0.31),
                            end: Alignment(-0.21, 0.68),
                            colors: [
                              const Color(0xff49c42b),
                              const Color(0xff20bf55)
                            ],
                            stops: [0.0, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                          //TEXT
                          // padding: EdgeInsets.symmetric(horizontal: 20.0),
                          margin: EdgeInsets.only(top: 200, bottom: 25),
                          alignment: Alignment(-0.70, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff49c42b),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: Column(
                              children: [
                                registrationTextField(
                                  // NAME FIELD
                                  controller: nameController,
                                  autofillHints: [AutofillHints.name],
                                  hintText: "Jhon Dohan",
                                  labelText: "Name",
                                  prefixIcon: Icon(
                                    Icons.account_circle_outlined,
                                    color: Color(0xff49c42b),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    } else if (!namevalidation
                                        .hasMatch(value)) {
                                      return 'Your entire name is invalid';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _name =
                                          value; //STORE INPUT VALUE _email VARIABLE
                                    });
                                  },
                                ),
                                registrationTextField(
                                  // ID FIELD
                                  controller: idController,
                                  keyboardType: TextInputType.number,
                                  hintText: "1912020678",
                                  labelText: "Student's or Teacher's ID",
                                  prefixIcon: Icon(
                                    Icons.app_registration_outlined,
                                    color: Color(0xff49c42b),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your university id';
                                    } else if (!idvalidation.hasMatch(value)) {
                                      return 'Your entire id does not correct.\nPlease enter your university id';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _id =
                                          value; //STORE INPUT VALUE _email VARIABLE
                                    });
                                  },
                                ),
                                registrationTextField(
                                  // EMAIL FIELD
                                  controller: emailController,
                                  autofillHints: [AutofillHints.email],
                                  hintText: "cse_1912020678@lus.ac.bd",
                                  labelText: "University Email",
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Color(0xff49c42b),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your university email';
                                    } else if (!emailvalidation
                                        .hasMatch(value)) {
                                      return 'Your entire email does not correct.\nPlease enter your university email';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _email =
                                          value; //STORE INPUT VALUE _email VARIABLE
                                    });
                                  },
                                ),
                                registrationTextField(
                                  // PASSWORD FIELD
                                  controller: passwordController,
                                  hintText: "n^Qu*73)",
                                  labelText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    color: Color(0xff49c42b),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 8) {
                                      return 'Your password must have 8 character';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _pass =
                                          value; //STORE INPUT VALUE _email VARIABLE
                                    });
                                  },
                                ),
                                registrationTextField(
                                  // CONFIRM PASSWORD FIELD
                                  controller: confirmPasswordController,
                                  hintText: "n^Qu*73)",
                                  labelText: "Confirm Password",
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    color: Color(0xff49c42b),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please re-enter your password';
                                    } else if (value.length < 8) {
                                      return 'Your password must have 8 character';
                                    } else if (_pass != value) {
                                      return 'Your password & confirm password doesn\'t matches';
                                    } else if (!validator.password(value)) {
                                      return 'Your password not strong';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _conPass =
                                          value; //STORE INPUT VALUE _pass VARIABLE
                                    });
                                  },
                                ),
                                dropdown_button(
                                  hint_text: 'Department',
                                  value: deptselectedType,
                                  onChanged: (value) {
                                    //print('$value'); //when I clicked then it print that value
                                    setState(() {
                                      deptselectedType = value;
                                    });
                                  },
                                  itemtyType: _departmentType,
                                ),
                                dropdown_button(
                                  hint_text: 'Your Identity',
                                  value: selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedType = value;
                                    });
                                  },
                                  itemtyType: _identityType,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              elevated_button(
                                // REGISTER BUTTON
                                margin: EdgeInsets.only(top: 30),
                                button_container_height: 45,
                                buttonTxt: 'Register',
                                horizontal_padding: 50,
                                vertical_padding: 0,
                                onPressed: () async {
                                  //CHECK INPUT FIELD VALIDATION
                                  if (_formkey.currentState!.validate()) {
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            _email,
                                            _conPass,
                                            _name,
                                            _id,
                                            deptselectedType,
                                            selectedType);
                                    if (result == null) {
                                      setState(() {
                                        var error =
                                            'Please supply a valid email';
                                      });
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => loginPage(),
                                      ),
                                    );
                                  }
                                  ;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //TEXT
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 30),
                                    child: Text(
                                      "Have an account?",
                                      style: TextStyle(
                                        fontFamily: 'JosefinSans',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // LOGIN BUTTON
                                    child: textButton(
                                      nextPage: loginPage(),
                                      buttonTxt: 'Login',
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
