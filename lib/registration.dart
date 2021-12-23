import 'dart:ui';

import 'package:flutter/material.dart';

class registration extends StatelessWidget {
  const registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      alignment: Alignment(0, 0.1),
      child: Text(
        'Work is underway to develop Registration page.',
        textAlign: TextAlign.center,
      ),
    );
  }
}
