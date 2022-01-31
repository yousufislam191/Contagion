import 'package:flutter/material.dart';

class dropdown_button extends StatelessWidget {
  final hint_text;
  final Object? value;
  final void Function(Object?)? onChanged;
  final List<String> itemtyType;
  const dropdown_button(
      {Key? key,
      required this.hint_text,
      required this.value,
      required this.onChanged,
      required this.itemtyType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 4),
      child: DropdownButton(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Color(0xff49c42b),
        ),
        underline: Container(
          color: Color(0xff49c42b),
          height: 1,
        ),
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
