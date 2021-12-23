import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lu_ahatting_application/clickLogin.dart';
import 'package:lu_ahatting_application/forgotPass.dart';
import 'package:lu_ahatting_application/registration.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var textEditingController = TextEditingController();

  bool _secure = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // margin: EdgeInsets.all(25.0),

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
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
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
                  Pin(size: 323.0, start: -42.0),
                  Pin(size: 323.0, start: -178.0),
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
                Column(
                  children: [
                    Container(
                      //TEXT
                      margin: EdgeInsets.only(top: 250),
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
                    Container(
                      // EMAIL FIELD
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      margin: EdgeInsets.only(top: 50),
                      // height: 60,
                      child: Material(
                        elevation: 10,
                        shadowColor: Colors.black54,
                        borderRadius: BorderRadius.circular(50.0),
                        child: TextField(
                          cursorColor: Color(0xff49c42b),
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'JosefinSans',
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Color(0xffe9e4e4),
                            filled: true,
                            hintText: "Enter your university email",
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'JosefinSans',
                              fontStyle: FontStyle.normal,
                            ),
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Color(0xff49c42b),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // PASSWORD FIELD
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      margin: EdgeInsets.only(top: 30),
                      child: Material(
                        elevation: 10,
                        shadowColor: Colors.black54,
                        borderRadius: BorderRadius.circular(50.0),
                        child: TextField(
                          controller: textEditingController,
                          cursorColor: Color(0xff49c42b),
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'JosefinSans',
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Color(0xffe9e4e4),
                            filled: true,
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontFamily: 'JosefinSans',
                              fontStyle: FontStyle.normal,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff49c42b),
                            ),
                            suffixIcon: GestureDetector(
                              child: Icon(
                                _secure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff49c42b),
                              ),
                              onTap: () {
                                setState(() {
                                  _secure = !_secure;
                                });
                              },
                            ),
                          ),
                          obscureText: _secure,
                          // obscuringCharacter: '*',
                        ),
                      ),
                    ),
                    Align(
                      //FORGOT PASSWORD BUTTON
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Color(0xff49c42b),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => forgotPass(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontFamily: 'JosefinSans',
                          ),
                        ),
                      ),
                      alignment: Alignment(0.8, 0),
                    ),
                    Container(
                      // LOGIN BUTTON
                      padding: EdgeInsets.symmetric(horizontal: 50),
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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => clickLogin(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
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
                            "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontSize: 18,
                            ),
                          ),
                        ),

                        // Registration BUTTON
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
                                    builder: (context) => registration(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register Now',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String _svg_eliu =
    '<svg viewBox="0.0 0.0 24.0 24.0" ><path  d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_ghlb7 =
    '<svg viewBox="2.0 4.0 20.0 16.0" ><path  d="M 22 6 C 22 4.900000095367432 21.10000038146973 4 20 4 L 4 4 C 2.900000095367432 4 2 4.900000095367432 2 6 L 2 18 C 2 19.10000038146973 2.900000095367432 20 4 20 L 20 20 C 21.10000038146973 20 22 19.10000038146973 22 18 L 22 6 Z M 20 6 L 12 11 L 4 6 L 20 6 Z M 20 18 L 4 18 L 4 8 L 12 13 L 20 8 L 20 18 Z" fill="#000000" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_hahodw =
    '<svg viewBox="0.0 0.0 24.0 24.0" ><path  d="M 0 0 L 24 0 L 24 24 L 0 24 L 0 0 Z" fill="none" fill-opacity="0.52" stroke="none" stroke-width="1" stroke-opacity="0.52" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_f9tfle =
    '<svg viewBox="4.0 1.0 16.0 21.0" ><path  d="M 18 8 L 17 8 L 17 6 C 17 3.240000009536743 14.76000022888184 1 12 1 C 9.239999771118164 1 7 3.240000009536743 7 6 L 7 8 L 6 8 C 4.900000095367432 8 4 8.899999618530273 4 10 L 4 20 C 4 21.10000038146973 4.900000095367432 22 6 22 L 18 22 C 19.10000038146973 22 20 21.10000038146973 20 20 L 20 10 C 20 8.899999618530273 19.10000038146973 8 18 8 Z M 9 6 C 9 4.340000152587891 10.34000015258789 3 12 3 C 13.65999984741211 3 15 4.340000152587891 15 6 L 15 8 L 9 8 L 9 6 Z M 18 20 L 6 20 L 6 10 L 18 10 L 18 20 Z M 12 17 C 13.10000038146973 17 14 16.10000038146973 14 15 C 14 13.89999961853027 13.10000038146973 13 12 13 C 10.89999961853027 13 10 13.89999961853027 10 15 C 10 16.10000038146973 10.89999961853027 17 12 17 Z" fill="#000000" fill-opacity="0.6" stroke="none" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
