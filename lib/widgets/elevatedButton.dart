import 'package:flutter/material.dart';

class elevated_button extends StatelessWidget {
  final String buttonTxt;
  final double horizontal_padding;
  final double vertical_padding;
  final void Function()? onPressed;
  final double? button_container_height;
  final EdgeInsetsGeometry? margin;
  const elevated_button({
    Key? key,
    required this.buttonTxt,
    required this.horizontal_padding,
    required this.vertical_padding,
    required this.onPressed,
    this.button_container_height,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: button_container_height,
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
          colors: [const Color(0xff4de927), const Color(0xff2ca70d)],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                horizontal: horizontal_padding, vertical: vertical_padding),
            //deactivate color & shadow
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: onPressed,
        // onPressed: () async {
        //   //CHECK INPUT FIELD VALIDATION
        //   if (_formkey.currentState!.validate()) {
        //     try {
        //       final newUser = await _auth.signInWithEmailAndPassword(
        //           email: _email, password: _pass);
        //       if (newUser != null) {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => loginVerification(),
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
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               AlertDialog(
        //                 title: Center(child: Text('User not found!!..')),
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
          buttonTxt,
          style: TextStyle(
            fontFamily: 'JosefinSans',
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
