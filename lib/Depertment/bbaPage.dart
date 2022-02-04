import 'package:flutter/material.dart';
class BBA extends StatelessWidget {
  const BBA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BBA"),
      ),
      body: Center(
        child: Text("This is a My Course Page"),
      ),
    );
  }
}