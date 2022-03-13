import 'dart:async';

import 'package:adobe_xd/blend_mask.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';

class email_verification extends StatefulWidget {
  const email_verification({Key? key}) : super(key: key);

  @override
  State<email_verification> createState() => _email_verificationState();
}

class _email_verificationState extends State<email_verification> {
  bool isEmailVerified = false;
  Timer? timer;
  late double height, width;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVE();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVE() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Fluttertoast.showToast(msg: (e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? loginPage()
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
                      Center(
                        child: Text('Verify Email'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
}
