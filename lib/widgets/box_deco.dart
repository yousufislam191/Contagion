import 'package:flutter/material.dart';

class box_deco extends StatelessWidget {
  // AuthService userProvider;
  final String text;
  box_deco({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80.0,
      color: Colors.black,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              )),
          child: new Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
