import 'package:flutter/material.dart';
class PublicHealth extends StatelessWidget {
  const PublicHealth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PublicHealth"),
      ),
      body: Center(
        child: Text("This is a My Course Page"),
      ),
    );
  }
}