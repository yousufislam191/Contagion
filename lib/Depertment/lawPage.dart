import 'package:flutter/material.dart';
class Law extends StatelessWidget {
  const Law({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Law"),
      ),
      body: Center(
        child: Text("This is a My Course Page"),
      ),
    );
  }
}