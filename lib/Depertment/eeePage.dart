import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/Depertment/elevatedButton.dart';

class EEE extends StatelessWidget {
  const EEE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EEE"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 300,
              width: 400,
              color: Colors.green,
              // decoration: BoxDecoration(
              //   image: const DecorationImage(
              //     image: AssetImage("assets/images/Lu-campus.jpg"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                elevatedButton(
                  text: "Notoce",
                  icon: Icons.book,
                  //widget:
                ),
                elevatedButton(
                  text: "Teachers",
                  icon: Icons.people,
                  //widget:
                ),
                elevatedButton(
                  text: "CR",
                  icon: Icons.person,
                  //widget:
                ),
              ],
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: null,
                  child: Text('Disabled Button'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 100),
                      elevation: 7,
                      shadowColor: Colors.black),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Disabled Button'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 100),
                      elevation: 7,
                      shadowColor: Colors.black),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Disabled Button'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 100),
                      elevation: 7,
                      shadowColor: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
