import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:lu_ahatting_application/loader.dart';
import 'package:lu_ahatting_application/widgets/elevatedButton.dart';
import 'package:lu_ahatting_application/widgets/loginTxtField.dart';

class forgotPass extends StatefulWidget {
  // loginPage({Key? key, this._identityValue}): super(key: key);
  @override
  State<forgotPass> createState() => _forgotPassState();
}

class _forgotPassState extends State<forgotPass> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final emailEditingController = TextEditingController();
  // final passEditingController = TextEditingController();

  RegExp emailvalidation = RegExp(r"^[a-z0-9_]+@lus.ac.bd$");

  String _email = '';
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   //TEXT
                              //   margin: EdgeInsets.only(top: 250, bottom: 20),
                              //   alignment: Alignment(-0.70, 0),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         'Login',
                              //         style: TextStyle(
                              //           fontFamily: 'JosefinSans',
                              //           fontSize: 34,
                              //           fontWeight: FontWeight.w700,
                              //           color: Color(0xff49c42b),
                              //         ),
                              //       ),
                              //       Text(
                              //         'Please login to continue',
                              //         style: TextStyle(
                              //           fontFamily: 'JosefinSans',
                              //           fontSize: 18,
                              //           fontWeight: FontWeight.normal,
                              //           color: Color(0xff49c42b),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(
                                height: 20,
                              ),
                              elevated_button(
                                  // Reset BUTTON
                                  button_container_height: 50,
                                  buttonTxt: 'Reset Password',
                                  horizontal_padding: 100,
                                  vertical_padding: 0,
                                  onPressed: () {
                                    _auth
                                        .sendPasswordResetEmail(email: _email)
                                        .then((value) =>
                                            Navigator.of(context).pop());
                                  }
                                  //CHECK INPUT FIELD VALIDATION
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
