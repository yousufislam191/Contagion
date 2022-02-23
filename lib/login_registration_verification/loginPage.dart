import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/head/headHomePage.dart';
import 'package:lu_ahatting_application/login_registration_verification/forgotPass.dart';
import 'package:lu_ahatting_application/loader.dart';
import 'package:lu_ahatting_application/models/user.dart';
import 'package:lu_ahatting_application/login_registration_verification/registration.dart';
import 'package:lu_ahatting_application/student/studentHomePage.dart';
import 'package:lu_ahatting_application/teacher/teacherHomePage.dart';
import 'package:lu_ahatting_application/widgets/elevatedButton.dart';
import 'package:lu_ahatting_application/widgets/loginTxtField.dart';
import 'package:lu_ahatting_application/widgets/txtButton.dart';
import 'package:regexed_validator/regexed_validator.dart';

class loginPage extends StatefulWidget {
  // loginPage({Key? key, this._identityValue}): super(key: key);
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final emailEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  RegExp emailvalidation = RegExp(r"^[a-z0-9_]+@lus.ac.bd$");

  String _email = '', _pass = '', _Tvalue = '', _Svalue = '';
  String? errorMessage;
  bool _secure = true;
  late double height, width;
  bool loading = false;

  final _formkey = GlobalKey<FormState>();

  // const loginPage({Key? key, required this._value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return loading
        ? ColorLoader3()
        : MaterialApp(
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
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        //DESIGN
                        Pinned.fromPins(
                          Pin(start: -137.0, end: 52.0),
                          Pin(size: 513.0, start: -292.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
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
                          Pin(size: 513.0, end: -231.0),
                          Pin(size: 513.0, start: -445.0),
                          child: BlendMask(
                            blendMode: BlendMode.multiply,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(9999.0, 9999.0)),
                                gradient: LinearGradient(
                                  begin: Alignment(0.0, -0.05),
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
                        Pinned.fromPins(
                          Pin(size: 223.0, end: -9.0),
                          Pin(size: 223.0, start: -65.0),
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
                          Pin(size: 323.0, start: -42.0),
                          Pin(size: 323.0, start: -178.0),
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
                          // autovalidateMode: true,
                          child: Column(
                            children: [
                              Container(
                                //TEXT
                                margin: EdgeInsets.only(top: 250, bottom: 20),
                                alignment: Alignment(-0.70, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        fontFamily: 'JosefinSans',
                                        fontSize: 34,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff49c42b),
                                      ),
                                    ),
                                    Text(
                                      'Please login to continue',
                                      style: TextStyle(
                                        fontFamily: 'JosefinSans',
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff49c42b),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    loginTextField(
                                      // EMAIL FIELD
                                      controller: emailEditingController,
                                      autofillHints: [AutofillHints.email],
                                      labelText: "Enter your university email",
                                      hintText: "cse_1912020678@lus.ac.bd",
                                      prefixIcon: Icon(
                                        Icons.email_rounded,
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
                                  ],
                                ),
                              ),
                              loginTextField(
                                // PASSWORD FIELD
                                controller: passEditingController,
                                labelText: "Enter your password",
                                hintText: "n^Qu*73)",
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color(0xff49c42b),
                                ),
                                suffixIcon: GestureDetector(
                                  child: Icon(
                                    _secure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Color(0xff49c42b),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _secure = !_secure;
                                    });
                                  },
                                ),
                                obscureText: _secure,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (!validator.password(value)) {
                                    return 'Your must be 8 character';
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
                              Align(
                                child: textButton(
                                  buttonTxt: 'Forgot password?',
                                  nextPage: forgotPass(),
                                ),
                                alignment: Alignment(0.8, 0),
                              ),
                              elevated_button(
                                // LOGIN BUTTON
                                button_container_height: 50,
                                buttonTxt: 'Login',
                                horizontal_padding: 100,
                                vertical_padding: 0,
                                onPressed: () async {
                                  //CHECK INPUT FIELD VALIDATION
                                  if (_formkey.currentState!.validate()) {
                                    setState(() => loading = true);

                                    try {
                                      final newUser = await _auth
                                          .signInWithEmailAndPassword(
                                              email: _email,
                                              password:
                                                  _pass); // login with user email & pass

                                      // if login successfull then go to the if condition
                                      if (newUser != null) {
                                        final user = await _auth
                                            .currentUser!; // when user login with their email & pass then will find the current user
                                        final userID =
                                            user.uid; // get current user 'uid'

                                        List<String> dept = List.filled(11,
                                            'null'); // declare a String type List
                                        dept[0] = 'BBA';
                                        dept[1] = 'CSE';
                                        dept[2] = 'English';
                                        dept[3] = 'EEE';
                                        dept[4] = 'Civil Engineering';
                                        dept[5] = 'Architecture';
                                        dept[6] = 'Law';
                                        dept[7] = 'Islamic Studies';
                                        dept[8] = 'Public Health';
                                        dept[9] =
                                            'Tourism & Hospitality Management';
                                        dept[10] = 'Bangla';

                                        List<String> identity = List.filled(2,
                                            'null'); // declare a String type List
                                        identity[0] = 'Student';
                                        identity[1] = 'Teacher';
                                        // identity[2] = 'Dept. Head';

                                        for (int i = 0; i < 11; i++) {
                                          String _dept = dept[i];
                                          for (int i = 0; i < 2; i++) {
                                            // we use loop for matchin collection with database
                                            String _identity = identity[
                                                i]; // convert List Srting to String
                                            try {
                                              // when user login then it will find user identity from database & keep the identity value in '_value' variable
                                              DocumentSnapshot value =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(_dept)
                                                      .doc(_dept)
                                                      .collection(_identity)
                                                      .doc(userID)
                                                      .get();

                                              getCurrentUserData(value);

                                              _Svalue = (value[
                                                  'identity']); // keep the identity value
                                              _Tvalue = (value[
                                                  'designation']); // keep the identity value
                                              // UserModel(value);
                                              break;
                                            } catch (e) {
                                              print(e);
                                            }

                                            // StreamBuilder(
                                            //     stream: FirebaseFirestore
                                            //         .instance
                                            //         .collection(_dept)
                                            //         .doc(_dept)
                                            //         .collection(_identity)
                                            //         .doc((await _auth.currentUser)!.uid)
                                            //         .snapshots(),
                                            //     builder: (BuildContext,
                                            //         AsyncSnapshot<
                                            //                 QuerySnapshot<
                                            //                     Map<String,
                                            //                         dynamic>>>
                                            //             snapshot) {
                                            //       if (snapshot.hasData &&
                                            //           snapshot.data != null) {
                                            //         // print("Total documents: ${snapshot.data!.docs.length}");
                                            //         if (snapshot.data!.docs
                                            //             .isNotEmpty) {
                                            //           return ListView.builder(
                                            //             itemCount: snapshot
                                            //                 .data!.docs.length,
                                            //             itemBuilder:
                                            //                 (BuildContext,
                                            //                     int index) {
                                            //               Map<String, dynamic>
                                            //                   docData = snapshot
                                            //                       .data!
                                            //                       .docs[index]
                                            //                       .data();

                                            //               if (docData.isEmpty) {
                                            //                 return const Text(
                                            //                   "Document is Empty",
                                            //                   textAlign:
                                            //                       TextAlign
                                            //                           .center,
                                            //                 );
                                            //               }

                                            //               String name = docData[
                                            //                   getData.name];
                                            //               String email =
                                            //                   docData[getData
                                            //                       .email];

                                            //               return getCurrentUserData();
                                            //             },
                                            //           );
                                            //         } else {
                                            //           return const Center(
                                            //             child: Text(
                                            //                 'Document aren\'t availavle'),
                                            //           );
                                            //         }
                                            //       } else {
                                            //         return const Center(
                                            //           child:
                                            //               Text('Getting Error'),
                                            //         );
                                            //       }
                                            //     });
                                          }
                                        }

                                        if (_Svalue == 'Student') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  studentHomePage(),
                                            ),
                                          );
                                          Fluttertoast.showToast(
                                              msg: "Successfully login.");
                                        } else if (_Tvalue == 'Head') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  headHomePage(),
                                            ),
                                          );
                                          Fluttertoast.showToast(
                                              msg: "Successfully login.");
                                        } else if (_Tvalue == 'Lecturer') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  teacherHomePage(),
                                            ),
                                          );
                                          Fluttertoast.showToast(
                                              msg: "Successfully login.");
                                        } else if (_Tvalue == 'Professor') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  teacherHomePage(),
                                            ),
                                          );
                                          Fluttertoast.showToast(
                                              msg: "Successfully login.");
                                        } else if (_Tvalue ==
                                            'Assistant Professor') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  teacherHomePage(),
                                            ),
                                          );
                                          Fluttertoast.showToast(
                                              msg: "Successfully login.");
                                        } else if (_Tvalue ==
                                            'Associate Professor') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  teacherHomePage(),
                                            ),
                                          );
                                          Fluttertoast.showToast(
                                              msg: "Successfully login.");
                                        }
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    } on FirebaseAuthException catch (error) {
                                      setState(() {
                                        loading = false;
                                      });
                                      switch (error.code) {
                                        case "invalid-email":
                                          errorMessage =
                                              "Your email address appears to be incorrect.";
                                          break;
                                        case "wrong-password":
                                          errorMessage =
                                              "Your password is wrong.";
                                          break;
                                        case "user-not-found":
                                          errorMessage =
                                              "User with this email doesn't exist.";
                                          break;
                                        case "user-disabled":
                                          errorMessage =
                                              "User with this email has been disabled.";
                                          break;
                                        case "too-many-requests":
                                          errorMessage = "Too many requests";
                                          break;
                                        case "operation-not-allowed":
                                          errorMessage =
                                              "Signing in with Email and Password is not enabled.";
                                          break;
                                        case "network-request-failed":
                                          errorMessage =
                                              "You have no internet connection.";
                                          break;
                                        default:
                                          errorMessage =
                                              "An undefined Error happened.";
                                      }
                                      Fluttertoast.showToast(
                                          msg: errorMessage!);
                                      print(error.code);
                                    }
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
                                      "Don't have an account?",
                                      style: TextStyle(
                                        fontFamily: 'JosefinSans',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // Registration BUTTON
                                    child: textButton(
                                      nextPage: registration(),
                                      buttonTxt: 'Register Now',
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
                ),
              ),
            ),
          );
  }
}
