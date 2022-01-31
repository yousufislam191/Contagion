import 'package:flutter/material.dart';

class loginTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final void Function(String)? onChanged;
  const loginTextField(
      {Key? key,
      required this.controller,
      this.keyboardType,
      required this.validator,
      this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      this.autofillHints,
      this.obscureText = false,
      required this.onChanged,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.only(top: 30),
      // height: 60,
      child: Material(
        elevation: 10,
        shadowColor: Colors.black54,
        borderRadius: BorderRadius.circular(50.0),
        child: TextFormField(
          controller: controller,
          cursorColor: Color(0xff49c42b),
          autofillHints: autofillHints,
          autocorrect: true,
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'JosefinSans',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide.none,
            ),
            fillColor: Color(0xffe9e4e4),
            filled: true,
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.grey[800],
              fontSize: 18,
              fontFamily: 'JosefinSans',
              fontStyle: FontStyle.normal,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 18,
              fontFamily: 'JosefinSans',
              fontStyle: FontStyle.normal,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
