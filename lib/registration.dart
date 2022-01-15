// ignore_for_file: unused_label

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:lu_ahatting_application/loginPage.dart';
import 'package:regexed_validator/regexed_validator.dart';

class registration extends StatefulWidget {
  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final _formkey = GlobalKey<FormState>();

  var _name, _id, _email, _pass;
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
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
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
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
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
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
                        margin: EdgeInsets.only(top: 200),
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
                      Container(
                        // NAME FIELD
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 30),
                        child: Material(
                          child: TextFormField(
                            controller: nameController,
                            cursorColor: Color(0xff49c42b),
                            autofillHints: [AutofillHints.name],
                            autocorrect: true,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'JosefinSans',
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontFamily: 'JosefinSans',
                                fontStyle: FontStyle.normal,
                              ),
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                                color: Color(0xff49c42b),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              } else if (!namevalidation.hasMatch(value)) {
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
                        ),
                      ),
                      Container(
                        // ID FIELD
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 5),
                        child: Material(
                          child: TextFormField(
                            controller: idController,
                            cursorColor: Color(0xff49c42b),
                            autocorrect: true,
                            keyboardType: TextInputType.number,
                            // maxLength: 10,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'JosefinSans',
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              hintText: "Student's or Teacher's ID",
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontFamily: 'JosefinSans',
                                fontStyle: FontStyle.normal,
                              ),
                              prefixIcon: Icon(
                                Icons.app_registration_outlined,
                                color: Color(0xff49c42b),
                              ),
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
                                _id = value; //STORE INPUT VALUE _email VARIABLE
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        // EMAIL FIELD
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 5),
                        child: Material(
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: Color(0xff49c42b),
                            autofillHints: [AutofillHints.email],
                            autocorrect: true,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'JosefinSans',
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              hintText: "University Email",
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontFamily: 'JosefinSans',
                                fontStyle: FontStyle.normal,
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(0xff49c42b),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your university email';
                              } else if (!emailvalidation.hasMatch(value)) {
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
                        ),
                      ),
                      Container(
                        // PASSWORD FIELD
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 5),
                        child: Material(
                          child: TextFormField(
                            controller: passwordController,
                            cursorColor: Color(0xff49c42b),
                            autocorrect: true,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'JosefinSans',
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontFamily: 'JosefinSans',
                                fontStyle: FontStyle.normal,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                color: Color(0xff49c42b),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (!validator.password(value)) {
                                return 'Your must be 8 character';
                              }
                              return null;
                            },
                            // onChanged: (value) {
                            //   setState(() {
                            //     _pass =
                            //         value; //STORE INPUT VALUE _pass VARIABLE
                            //   });
                            // },
                          ),
                        ),
                      ),
                      Container(
                        // CONFIRM PASSWORD FIELD
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 5),
                        child: Material(
                          child: TextFormField(
                            controller: confirmPasswordController,
                            cursorColor: Color(0xff49c42b),
                            autocorrect: true,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'JosefinSans',
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff49c42b)),
                              ),
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontFamily: 'JosefinSans',
                                fontStyle: FontStyle.normal,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                color: Color(0xff49c42b),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please re-enter your password';
                              } else if (!validator.password(value)) {
                                return 'Your must be 8 character';
                              } else if (!(passwordController ==
                                  confirmPasswordController)) {
                                return 'Your password & confirm password doesn\'t matches';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _pass =
                                    value; //STORE INPUT VALUE _pass VARIABLE
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 10),
                        // decoration: BoxDecoration(border: Border.symmetric(vertical: 20.0),),
                        child: DropdownButton(
                          icon: Icon(
                            // Icons.attractions_outlined,
                            Icons.arrow_drop_down,
                            color: Color(0xff49c42b),
                          ),
                          underline: Container(
                            color: Color(0xff49c42b),
                            height: 1,
                          ),
                          hint: Text(
                            'Department',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'JosefinSans',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          isExpanded: true,
                          value: deptselectedType,
                          onChanged: (value) {
                            print(
                                '$value'); //when I clicked then it print that value
                            setState(() {
                              deptselectedType = value;
                            });
                          },
                          items: _departmentType.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                  fontFamily: 'JosefinSans',
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 4),
                        // decoration: BoxDecoration(border: Border.symmetric(vertical: 20.0),),
                        child: DropdownButton(
                          icon: Icon(
                            // Icons.assignment_ind_outlined,
                            Icons.arrow_drop_down,
                            color: Color(0xff49c42b),
                          ),
                          underline: Container(
                            color: Color(0xff49c42b),
                            height: 1,
                          ),
                          hint: Text(
                            'Your Identity',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'JosefinSans',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          isExpanded: true,
                          value: selectedType,
                          onChanged: (value) {
                            print(
                                '$value'); //when I clicked then it print that value
                            setState(() {
                              selectedType = value;
                            });
                          },
                          items: _identityType.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                  fontFamily: 'JosefinSans',
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        // REGISTER BUTTON
                        margin: EdgeInsets.only(top: 30),
                        height: 45,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 7,
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment(0.85, 0.19),
                            end: Alignment(-1.58, 0.0),
                            colors: [
                              const Color(0xff4de927),
                              const Color(0xff2ca70d)
                            ],
                            stops: [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              //deactivate color & shadow
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => loginPage(),
                                ),
                              );
                            }
                          },
                          // onPressed: () async {
                          //   //CHECK INPUT FIELD VALIDATION
                          //   if (_formkey.currentState!.validate()) {
                          //     try {
                          //       final newUser =
                          //           await _auth.signInWithEmailAndPassword(
                          //               email: _email, password: _pass);
                          //       if (newUser != null) {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => loginPage(),
                          //           ),
                          //         );
                          //       }
                          //     } catch (e) {
                          //       print(e);
                          //       // print("user not found");
                          //       showDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           return Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.center,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.center,
                          //             children: [
                          //               AlertDialog(
                          //                 title: Center(
                          //                     child:
                          //                         Text('User not found!!..')),
                          //               ),
                          //             ],
                          //           );
                          //         },
                          //       );
                          //     }
                          //   } else {
                          //     print('Unsuccessfull');
                          //   }
                          // },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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

                          // LOGIN BUTTON
                          Container(
                            child: Align(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Color(0xff49c42b),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => loginPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
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
        ),
      ),
    );
  }
}
