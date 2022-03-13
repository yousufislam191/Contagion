import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/services/auth.dart';

class editTextField1 extends StatelessWidget {
  // AuthService userProvider;
  // final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? initialvalue;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Iterable<String>? autofillHints;
  final void Function(String)? onChanged;
  final int? maxLength;
  final int? maxLine;
  final double? width;
  editTextField1({
    Key? key,
    // required this.controller,
    this.keyboardType,
    required this.validator,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.autofillHints,
    this.onChanged,
    this.maxLength,
    this.maxLine,
    this.width,
    this.initialvalue,

    // required this.userProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 0),
      child: Material(
        child: TextFormField(
          initialValue: initialvalue,
          // expands: true,
          cursorWidth: 2,
          maxLines: maxLine,
          // controller: controller,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.green, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Color(0xff49c42b), width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Color(0xff49c42b), width: 1.5),
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
