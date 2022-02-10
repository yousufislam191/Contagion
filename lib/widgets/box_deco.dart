import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lu_ahatting_application/services/auth.dart';

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
