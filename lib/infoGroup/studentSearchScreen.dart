import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lu_ahatting_application/messages/chatPage3.dart';
import 'package:lu_ahatting_application/models/user.dart';

class studentSearchScreen extends StatefulWidget {
  final Title;
  final currentUserValue;
  const studentSearchScreen({Key? key, this.Title, this.currentUserValue})
      : super(key: key);

  @override
  _studentSearchScreenState createState() =>
      _studentSearchScreenState(Title, currentUserValue);
}

class _studentSearchScreenState extends State<studentSearchScreen> {
  final String Title;
  final currentUserValue;
  _studentSearchScreenState(this.Title, this.currentUserValue);

  TextEditingController _searchController = TextEditingController();
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersPastTripsStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var tripSnapshot in _allResults) {
        var id = UserModel.fromSnapshot(tripSnapshot).id!.toLowerCase();

        if (id.contains(_searchController.text.toLowerCase())) {
          showResults.add(tripSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersPastTripsStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection(Title)
        .doc(Title)
        .collection('Student')
        .where('id', isGreaterThanOrEqualTo: _searchController.text)
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: new Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff49c42b),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: TextField(
            controller: _searchController,
            cursorColor: Color(0xff49c42b),
            autocorrect: true,
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
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              labelStyle: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontFamily: 'JosefinSans',
                fontStyle: FontStyle.normal,
              ),
              hintText: 'Search student by student id...',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
                fontFamily: 'JosefinSans',
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: _resultsList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> docData = _resultsList[index].data();

              String name = docData[getListData.name];
              String uid = docData[getListData.uid];
              String id = docData[getListData.id];

              return currentUserId == uid
                  ? Container(height: 0)
                  : ListTile(
                      // return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                chatPage3(targetUserValue: docData),
                          ),
                        );
                      },
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.capitalize(),
                                // 'name',
                                style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                id,
                                // 'designation',
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
            }),
      )),
    );
  }
}
