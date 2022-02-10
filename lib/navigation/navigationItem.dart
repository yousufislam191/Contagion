import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/widgets/chatHomePage.dart';

class NavItem extends StatelessWidget {
  const NavItem(
      {Key? key, required this.title, required this.icon, required this.widget})
      : super(key: key);

  final String title;
  final IconData icon;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(this.icon),
      // contentPadding: EdgeInsets.symmetric(vertical: 10),
      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
      title: Text(
        this.title,
        style: TextStyle(
          fontFamily: 'JosefinSans',
          fontSize: 16,
        ),
      ),
      trailing: Icon(this.icon, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => this.widget),
        );
      },
    );
  }
}
