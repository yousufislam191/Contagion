import 'package:flutter/material.dart';

class Editdropdown_button extends StatelessWidget {
  final hint_text;
  final String? value;
  final void Function(Object?)? onChanged;
  final List<String> itemtyType;
  final String? Function(String?)? validator;
  const Editdropdown_button(
      {Key? key,
      required this.hint_text,
      required this.value,
      required this.onChanged,
      required this.itemtyType,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 4),
      child: DropdownButtonFormField(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Color(0xff49c42b),
        ),
        decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(
          color: Color(0xff49c42b),
          width: 1.5,
          style: BorderStyle.solid,
        ))),
        hint: Text(
          hint_text,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 18,
            fontFamily: 'JosefinSans',
            fontStyle: FontStyle.normal,
          ),
        ),
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        validator: validator,
        items: itemtyType.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontFamily: 'JosefinSans',
                fontStyle: FontStyle.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
