import 'package:flutter/material.dart';

class registrationTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;
  final void Function(String)? onChanged;
  final int? maxLength;
  const registrationTextField({
    Key? key,
    required this.controller,
    this.keyboardType,
    required this.validator,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.autofillHints,
    this.onChanged,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 0),
      child: Material(
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          autofillHints: autofillHints,
          maxLength: maxLength,
          // textAlign: textAlign,
          cursorColor: Color(0xff49c42b),
          autocorrect: true,
          // maxLength: 10,
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'JosefinSans',
          ),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff49c42b)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff49c42b)),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff49c42b)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8), // inside padding
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
          ),
        ),
      ),
    );
  }
}
