import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lu_ahatting_application/login_registration_verification/loginPage.dart';

class openPage extends StatefulWidget {
  const openPage({Key? key}) : super(key: key);

  @override
  State<openPage> createState() => _openPageState();
}

class _openPageState extends State<openPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => loginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lu Chatting Application',
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: -77.3, end: -87.3),
                  Pin(size: 424.0, start: -99.5),
                  child:
                      // Adobe XD layer: 'Path 3' (shape)
                      SvgPicture.string(
                    _svg_c4tyn,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: -69.3, end: -69.3),
                  Pin(size: 372.8, start: -84.4),
                  child:
                      // Adobe XD layer: 'Path 2' (shape)
                      SvgPicture.string(
                    _svg_qji5pz,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: -56.0, end: -56.2),
                  Pin(size: 326.9, start: -71.0),
                  child: SvgPicture.string(
                    _svg_kkfqm,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 323.0, end: -195.0),
                  Pin(size: 323.0, start: -130.0),
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
                Pinned.fromPins(
                  Pin(size: 223.0, end: 0.0),
                  Pin(size: 223.0, start: -161.0),
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
                  Pin(size: 223.0, end: -130.0),
                  Pin(size: 223.0, start: -120.0),
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
                  Pin(size: 280.0, start: 20.0),
                  Pin(size: 39.0, start: 70.0),
                  child: Text(
                    'Leading University',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 28,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 140.0, start: 20.0),
                  Pin(size: 20.0, start: 103.0),
                  child: Text(
                    'A Promise to Lead',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 16,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 97.0, start: 36.0),
                  Pin(size: 101.0, middle: 0.1900),
                  child:
                      // Adobe XD layer: 'Leading_University_…' (shape)
                      Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/Lulogo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 264.0, middle: 0.5244),
                  Pin(size: 22.0, middle: 0.3927),
                  child: Text(
                    'Welcome to Our Chatting App',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 18,
                      color: const Color(0xff49c42b),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 39.0, end: 39.0),
                  Pin(size: 16.0, middle: 0.4165),
                  child: Text(
                    'Enhance your communication with teachers & students',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontSize: 13,
                      color: const Color(0xff49c42b),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 23.0, end: 23.0),
                  Pin(size: 248.0, middle: 0.6868),
                  child:
                      // Adobe XD layer: '5518570' (shape)
                      Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/images/openPage.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                // Pinned.fromPins( // START BUTTON
                //   Pin(size: 299.0, end: 64.0),
                //   Pin(size: 39.0, end: 86.0),
                //   child: PageLink(
                //     links: [
                //       PageLinkInfo(
                //         transition: LinkTransition.PushLeft,
                //         ease: Curves.easeOut,
                //         duration: 0.3,
                //         pageBuilder: () => loginPage(),
                //       ),
                //     ],
                //     // onTap: () {
                //     //   Navigator.push(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //       builder: (context) => loginPage(),
                //     //     ),
                //     //   );
                //     // },
                //     child: Stack(
                //       children: <Widget>[
                //         Pinned.fromPins(
                //           Pin(start: 0.0, end: 29.0),
                //           Pin(start: 0.0, end: 0.0),
                //           child: SvgPicture.string(
                //             _svg_a1tcyh,
                //             allowDrawingOutsideViewBox: true,
                //             fit: BoxFit.fill,
                //           ),
                //         ),
                //         Pinned.fromPins( // arrow round
                //           Pin(size: 39.0, end: 0.0),
                //           Pin(start: 0.0, end: 0.0),
                //           child: Container(
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.all(
                //                   Radius.elliptical(9999.0, 9999.0)),
                //               color: const Color(0xff49c42b),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: const Color(0x40000000),
                //                   offset: Offset(1, 3),
                //                   blurRadius: 5,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         Pinned.fromPins( // arrow icon
                //           Pin(size: 19.0, end: 10.0),
                //           Pin(size: 12.5, middle: 0.5283),
                //           child: Stack(
                //             children: <Widget>[
                //               Pinned.fromPins(
                //                 Pin(size: 8.3, end: 0.0),
                //                 Pin(size: 5.9, start: 0.0),
                //                 child: SvgPicture.string(
                //                   _svg_a55q5z,
                //                   allowDrawingOutsideViewBox: true,
                //                   fit: BoxFit.fill,
                //                 ),
                //               ),
                //               Pinned.fromPins(
                //                 Pin(size: 8.5, end: 0.0),
                //                 Pin(size: 6.6, end: 0.0),
                //                 child: SvgPicture.string(
                //                   _svg_ezc4tq,
                //                   allowDrawingOutsideViewBox: true,
                //                   fit: BoxFit.fill,
                //                 ),
                //               ),
                //               Pinned.fromPins(
                //                 Pin(start: 0.0, end: 1.2),
                //                 Pin(size: 1.0, middle: 0.5163),
                //                 child: SvgPicture.string(
                //                   _svg_ccco8m,
                //                   allowDrawingOutsideViewBox: true,
                //                   fit: BoxFit.fill,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Pinned.fromPins(
                //           Pin(size: 66.0, middle: 0.4403),
                //           Pin(size: 26.0, middle: 0.8615),
                //           child: Text(
                //             'Start'.toUpperCase(),
                //             style: TextStyle(
                //               fontFamily: 'JosefinSans',
                //               fontSize: 21,
                //               color: const Color(0xff49c42b),
                //               fontWeight: FontWeight.w700,
                //             ),
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String _svg_c4tyn =
    '<svg viewBox="-77.3 -69.5 592.6 424.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="matrix(0.981627, 0.190809, -0.190809, 0.981627, -392.4, -129.66)" d="M 415.8460388183594 296.4890747070312 C 415.8460388183594 296.4890747070312 492.3614501953125 327.4660034179688 564.3495483398438 306.9269409179688 C 636.337646484375 286.3878784179688 645.5028686523438 254.6814422607422 703.7984008789062 214.3328857421875 C 782.9463500976562 159.5513916015625 922.1710815429688 168.9743499755859 922.1710815429688 168.9743499755859 L 909.9163818359375 -12.96177101135254 L 382.0187683105469 -12.96177101135254 L 415.8460388183594 296.4890747070312 Z" fill="#2c9a11" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_qji5pz =
    '<svg viewBox="-69.3 -54.4 566.6 372.8" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="matrix(0.996195, 0.087156, -0.087156, 0.996195, -422.5, -74.76)" d="M 415.8460388183594 296.4890747070312 C 415.8460388183594 296.4890747070312 492.3614501953125 327.4660034179688 564.3495483398438 306.9269409179688 C 636.337646484375 286.3878784179688 645.5028686523438 254.6814422607422 703.7984008789062 214.3328857421875 C 782.9463500976562 159.5513916015625 922.1710815429688 168.9743499755859 922.1710815429688 168.9743499755859 L 909.9163818359375 -12.96177101135254 L 382.0187683105469 -12.96177101135254 L 415.8460388183594 296.4890747070312 Z" fill="#3abc1a" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_kkfqm =
    '<svg viewBox="-56.0 -41.0 540.2 326.9" ><defs><filter id="shadow"><feDropShadow dx="0" dy="7" stdDeviation="6"/></filter><linearGradient id="gradient" x1="0.633946" y1="0.478658" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff49c42b"  /><stop offset="1.0" stop-color="#ff94cd86"  /></linearGradient></defs><path transform="translate(-438.0, -28.0)" d="M 415.8460388183594 296.4890747070312 C 415.8460388183594 296.4890747070312 492.3614501953125 327.4660034179688 564.3495483398438 306.9269409179688 C 636.337646484375 286.3878784179688 645.5028686523438 254.6814422607422 703.7984008789062 214.3328857421875 C 782.9463500976562 159.5513916015625 922.1710815429688 168.9743499755859 922.1710815429688 168.9743499755859 L 909.9163818359375 -12.96177101135254 L 382.0187683105469 -12.96177101135254 L 415.8460388183594 296.4890747070312 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_a1tcyh =
    '<svg viewBox="65.0 751.0 270.0 39.0" ><path transform="translate(503.0, 779.0)" d="M -171.5003814697266 10.99981689453125 L -418.4999694824219 10.99981689453125 C -423.7086181640625 10.99981689453125 -428.6055603027344 8.971549987792969 -432.2886352539062 5.288617134094238 C -435.9718627929688 1.60568368434906 -438.0002746582031 -3.291049480438232 -438.0002746582031 -8.499616622924805 C -438.0002746582031 -13.70851612091064 -435.9718627929688 -18.60554885864258 -432.2886352539062 -22.28861618041992 C -428.6056213378906 -25.97161674499512 -423.7086791992188 -27.99991607666016 -418.4999694824219 -27.99991607666016 L -171.5003814697266 -27.99991607666016 C -170.3248901367188 -27.99991607666016 -169.1472473144531 -27.89448356628418 -168.0001831054688 -27.68658256530762 C -177.2708892822266 -26.00621604919434 -183.9996185302734 -17.93778228759766 -183.9996185302734 -8.499616622924805 C -183.9996185302734 0.9371837377548218 -177.2708892822266 9.00611686706543 -168.0001831054688 10.68648338317871 C -169.1509857177734 10.89505004882812 -170.3286437988281 10.99981689453125 -171.5003814697266 10.99981689453125 Z" fill="#ffffff" stroke="#49c42b" stroke-width="4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_a55q5z =
    '<svg viewBox="330.7 765.0 8.3 5.9" ><path transform="translate(330.69, 765.0)" d="M 0 0 L 8.312660217285156 5.937614440917969" fill="none" stroke="#ffffff" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ezc4tq =
    '<svg viewBox="330.5 770.9 8.5 6.6" ><path transform="translate(330.5, 770.94)" d="M 0 6.5623779296875 L 8.500404357910156 0" fill="none" stroke="#ffffff" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ccco8m =
    '<svg viewBox="320.0 770.9 17.8 1.0" ><path transform="translate(320.0, 770.94)" d="M 0 0 L 17.81284332275391 0" fill="none" stroke="#ffffff" stroke-width="3" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
