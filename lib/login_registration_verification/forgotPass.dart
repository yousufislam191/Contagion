import 'package:flutter/material.dart';

class forgotPass extends StatelessWidget {
  const forgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      alignment: Alignment(0, 0.1),
      child: Text(
        'Work is underway to develop forgot password page.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
