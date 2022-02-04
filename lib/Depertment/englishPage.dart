import 'package:flutter/material.dart';
class English extends StatelessWidget {
  const English({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("English"),
      ),
      body: Center(
        child: Text("This is a My Course Page"),
      ),
    );
  }
}