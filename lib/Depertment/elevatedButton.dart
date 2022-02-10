import 'package:flutter/material.dart';

class elevatedButton extends StatelessWidget {
  const elevatedButton({Key? key, required this.text, required this.icon,
  //required this.widget
  })
      : super(key: key);

  final String text;
  final IconData icon;
  // final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            this.icon,
            color: Colors.black,
          ),
          Text(this.text, style: TextStyle(color: Colors.black))
        ],
      ),
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => this.widget),

        // );
      },
      style: ElevatedButton.styleFrom(
          // textStyle: TextStyle(color: Colors.black),
          side: BorderSide(width: 3, color: Colors.black),
          fixedSize: const Size(100, 100),
          primary: Colors.white,
          elevation: 7,
          shadowColor: Colors.black),
    );
  }
}
