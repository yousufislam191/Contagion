import 'package:flutter/material.dart';
class Bangla extends StatelessWidget {
  const Bangla({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bangla"),
      ),
      body: Center(
        child: Text("This is a My Course Page"),
      ),
    );
  }
}