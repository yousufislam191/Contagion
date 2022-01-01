import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
// import 'package:count_down_timer/count_down_timer.dart';

class loginVerification extends StatelessWidget {
  // const loginVerification({Key? key}) : super(key: key);
  // String _phone = '';

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
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  //IMAGE
                  Pin(size: 192.0, end: 22.0),
                  Pin(size: 238.0, start: 52.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                            'assets/images/verificationimg.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  //big circle
                  Pin(size: 223.0, middle: 0.4537),
                  Pin(size: 223.0, start: -35.0),
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
                            const Color(0x9c49c42b),
                            const Color(0x9c20bf55)
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  //small circle
                  Pin(size: 135.0, start: 26.0),
                  Pin(size: 135.0, start: -49.0),
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
                            const Color(0x9c49c42b),
                            const Color(0x9c20bf55)
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  margin: EdgeInsets.only(top: 250),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Verification',
                            style: TextStyle(
                              fontFamily: 'JosefinSans',
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff49c42b),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: Text(
                                    'A code has been sent to your email, which \nemail you used to create your account.',
                                    style: TextStyle(
                                      fontFamily: 'JosefinSans',
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Check your email.',
                                  style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: 16,
                                    color: Color(0xff49c42b),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    'Code',
                                    style: TextStyle(
                                      fontFamily: 'JosefinSans',
                                      fontSize: 16,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Please, enter the verification code',
                                  style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: 12,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                TextField(
                                  cursorColor: Color(0xff49c42b),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 4,
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
                                  ),
                                ),
                                // CountDownWidget(
                                //   phone: _phone,
                                //   padding: EdgeInsets.all(5),
                                //   decoration: BoxDecoration(
                                //     color: Color(0xffffffff),
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(5)),
                                //     border: Border.all(
                                //       width: 1,
                                //       color: Color(0xfff4f4f4),
                                //     ),
                                //   ),
                                //   startSeconds: 6,
                                //   onTapCallback: (timer) {
                                //     print(
                                //         'onTapCallback：current is ${timer.tick}s');
                                //   },
                                //   language: CountDown.EN,
                                //   verifyStr: "Send",
                                //   enableTS:
                                //       TextStyle(color: const Color(0xff000000)),
                                //   disableTS:
                                //       TextStyle(color: const Color(0xff999999)),
                                // ),
                                Align(
                                  //Resend code BUTTON
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Color(0xff49c42b),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Resend code?',
                                      style: TextStyle(
                                        fontFamily: 'JosefinSans',
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment(-0.9999999, 0),
                                ),
                                Container(
                                  // LOGIN BUTTON
                                  margin: EdgeInsets.only(top: 20),
                                  height: 40,
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
                                          MaterialStateProperty.all(
                                              Colors.transparent),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      // minimumSize: Size(width:50, height),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      '         Verify          ',
                                      style: TextStyle(
                                        fontFamily: 'JosefinSans',
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
