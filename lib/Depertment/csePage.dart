import 'package:flutter/material.dart';
class CSE extends StatelessWidget {
  const CSE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CSE"),
      ),
      body: Center(
        child: Text("This is a My Course Page"),
      ),
    );
  }
}