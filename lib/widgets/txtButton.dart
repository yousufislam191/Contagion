import 'package:flutter/material.dart';

class textButton extends StatelessWidget {
  final nextPage;
  final String buttonTxt;
  final double? fontSize;
  const textButton(
      {Key? key,
      required this.nextPage,
      required this.buttonTxt,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Color(0xff49c42b),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
            ),
          );
        },
        child: Text(
          buttonTxt,
          style: TextStyle(
            fontFamily: 'JosefinSans',
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
