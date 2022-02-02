import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  final int length;
  final Color? backgroundColor;
  final ImageProvider<Object>? backgroundImage;
  final String profileText;
  final TextEditingController? controller;
  final Color? searchbarCursorColor;
  final Color? searchbarIconColor;
  final List<Widget> tabs;
  final ImageProvider<Object> bodyImage;

  const homePage(
      {Key? key,
      required this.length,
      required this.backgroundColor,
      required this.backgroundImage,
      required this.profileText,
      required this.controller,
      required this.searchbarCursorColor,
      required this.searchbarIconColor,
      required this.tabs,
      required this.bodyImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: AppBar(
            backgroundColor: backgroundColor,
            elevation: 2,
            titleSpacing: 2,
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            title: Row(
              children: [
                // Drawer(),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: backgroundImage,
                ),
                SizedBox(width: 15),
                Text(
                  profileText,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            flexibleSpace: Container(
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //       colors: [Color(0xff49c42b), Color(0xFFB9FFA7)],
              //       begin: Alignment.bottomRight),
              // ),
              child: Form(
                child: Container(
                  // SEARCH FIELD
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.only(top: 80),
                  child: Material(
                    borderRadius: BorderRadius.circular(50.0),
                    child: TextFormField(
                      controller: controller,
                      cursorColor: searchbarCursorColor,
                      // autofillHints: [AutofillHints.email],
                      autocorrect: true,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'JosefinSans',
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color(0xffe9e4e4),
                        filled: true,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontFamily: 'JosefinSans',
                          fontStyle: FontStyle.normal,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: searchbarIconColor,
                        ),
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your university email';
                      //   } else if (!emailvalidation.hasMatch(value)) {
                      //     return 'Your entire email does not correct.\nPlease enter your university email';
                      //   }
                      //   return null;
                      // },
                      // onChanged: (value) {
                      //   setState(() {
                      //     _email =
                      //         value; //STORE INPUT VALUE _email VARIABLE
                      //   });
                      // },
                    ),
                  ),
                ),
              ),
            ),
            // actions: <Widget>[],
            bottom: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                labelStyle: TextStyle(
                  fontFamily: 'JosefinSans',
                  // fontSize: 26,
                  fontWeight: FontWeight.w700,
                  // color: Color(0xff49c42b),
                ),
                tabs: tabs),
          ),
        ),
        body: Container(
          // alignment: Alignment(-0.70, 0),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Image(
              image: bodyImage,
            ),
          ),
          // child: Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: const AssetImage('assets/images/backgroundImg.png'),
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
