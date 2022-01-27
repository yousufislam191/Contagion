import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:flutter/rendering.dart';
import 'package:lu_ahatting_application/loginVerification.dart';
import 'package:lu_ahatting_application/forgotPass.dart';
import 'package:lu_ahatting_application/registration.dart';
import 'package:lu_ahatting_application/widgets/elevatedButton.dart';
import 'package:lu_ahatting_application/widgets/loginTxtField.dart';
import 'package:lu_ahatting_application/widgets/txtButton.dart';
import 'package:regexed_validator/regexed_validator.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final emailEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  RegExp emailvalidation = RegExp(r"^[a-z0-9_]+@lus.ac.bd$");

  var _email, _pass;
  bool _secure = true;
  late double height, width;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

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
                          // padding: EdgeInsets.symmetric(horizontal: 30.0),
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
                              // Padding(padding: ),
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
                        loginTextField(
                          // EMAIL FIELD
                          controller: emailEditingController,
                          autofillHints: [AutofillHints.email],
                          labelText: "Enter your university email",
                          // hintText: "Enter your university email",
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Color(0xff49c42b),
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
                        loginTextField(
                          // PASSWORD FIELD
                          controller: passEditingController,
                          labelText: "Enter your password",
                          // hintText: "Enter your password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff49c42b),
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              _secure ? Icons.visibility : Icons.visibility_off,
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
                              _pass = value; //STORE INPUT VALUE _pass VARIABLE
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
                              try {
                                final newUser =
                                    await _auth.signInWithEmailAndPassword(
                                        email: _email, password: _pass);
                                if (newUser != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => loginVerification(),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print(e);
                                // print("user not found");
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AlertDialog(
                                          title: Center(
                                              child:
                                                  Text('User not found!!..')),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            } else {
                              print('Unsuccessfull');
                            }
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
