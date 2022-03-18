import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lu_ahatting_application/Utils/user_simple_preference.dart';
import 'package:lu_ahatting_application/widgets/ProfileWidget.dart';
import 'package:lu_ahatting_application/widgets/editDropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lu_ahatting_application/widgets/button_widget.dart';
import 'package:lu_ahatting_application/models/user_model.dart';
import 'package:lu_ahatting_application/widgets/profileTXTfield.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int selectedValue = 0;
  final _formkey = GlobalKey<FormState>();
  var batch;
  var section;
  String line = '';
  String number = '';
  String _call = '', _txt = '', call = '';
  late User1 user1;
  late var name;

  @override
  void initState() {
    super.initState();
    // batch = UserSimplePreferences.getBatch() ?? '';
    // section = UserSimplePreferences.getSection() ?? '';
    user1 = UserSimplePreferences.getUser1();
    _call = UserSimplePreferences.getUsername() ?? '';
    _txt = UserSimplePreferences.getLine() ?? '';
  }

  final nameController = TextEditingController();
  final idController = TextEditingController();
  final callController = TextEditingController();
  final emailController = TextEditingController();
  final txtController = TextEditingController();

  var selectedType, deptselectedType;
  var _batch = [
    'Batch: 47',
    'Batch: 48',
    'Batch: 49',
    'Batch: 50',
    'Batch: 51',
    'Batch: 52',
    'Batch: 53',
    'Batch: 54',
    'Batch: 55',
    'Batch: 56',
    'Batch: 57',
    'Batch: 58',
    'Batch: 59'
  ];
  var _section = [
    'Section: A',
    'Section: B',
    'Section: C',
    'Section: D',
    'Section: E',
    'Section: F',
    'Section: G',
    'Section: H',
    'Section: I',
  ];
  Reference storageReference = FirebaseStorage.instance.ref();
  File? image;
  bool valuefirst = false;
  // bool valuesecond = false;
  final user = FirebaseAuth.instance.currentUser;
  late String url;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        AppBar(
          title: Text("Edit Profile"),
          backgroundColor: Colors.green,
        ),
        Card(
          child: Container(
            height: 200,
            color: Colors.green,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ProfileWidget(imagePath: user1.imagePath),
                ),
                Align(
                    alignment: Alignment.center + Alignment(.3, .3),
                    child: IconButton(
                      icon: new Icon(Icons.camera_alt_rounded),
                      color: Colors.white,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) => Bottom_Sheet());
                      },
                    )),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                ),

                editTextField1(
                  // Call FIELD
                  initialvalue: _call,
                  // controller: callController,
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.number,
                  // hintText: "01*********",
                  labelText: "call",
                  prefixIcon: Icon(
                    Icons.call,
                    color: Color(0xff49c42b),
                  ),
                  validator: (value) {},
                  onChanged: (value) {
                    setState(() {
                      this._call = value; //STORE INPUT VALUE _email VARIABLE
                    });
                  },
                ),

                SizedBox(
                  width: 20,
                  height: 20,
                ),
                Editdropdown_button(
                  hint_text: 'Batch',
                  value: deptselectedType,
                  // validator: (value) => value == null ? 'Please select your batch' : null,
                  onChanged: (value) {
                    //print('$value'); //when I clicked then it print that value
                    setState(() {
                      deptselectedType = value;
                    });
                  },
                  itemtyType: _batch,
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),

                Editdropdown_button(
                  hint_text: 'Section',
                  value: selectedType,
                  // validator: (value) =>value == null ? 'Please select your section' : null,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  itemtyType: _section,
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '  Class Representative?',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontFamily: 'JosefinSans',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(
                      width: 115,
                    ),
                    Checkbox(
                      // checkColor: Colors.greenAccent,
                      activeColor: Color(0xff49c42b),
                      value: this.valuefirst,
                      onChanged: (value) {
                        setState(() {
                          this.valuefirst = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                editTextField1(
                  maxLine: 4,
                  initialvalue: _txt,
                  keyboardType: TextInputType.text,
                  // controller: txtController,
                  labelText: " About You",
                  validator: (value) {},
                  onChanged: (value) {
                    setState(() {
                      this._txt = value; //STORE INPUT VALUE _pass VARIABLE
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                  child: buildButton(),
                ),
                // RaisedButton(
                //   child: Text('Save'),
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
        )
      ]),
    ));
  }

  Widget Bottom_Sheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(this.context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  takephoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () {
                  takephoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  takephoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
      );
      if (image == null) return;
      final directory = await getApplicationDocumentsDirectory();
      name = basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final newImage = await File(image.path).copy(imageFile.path);

      setState(() => user1 = user1.copy(imagePath: newImage.path));
      uploadImageToFirebase(image);
      // final imageTemporary = File(image.path);
      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future uploadImageToFirebase(XFile image1) async {
    final ref = FirebaseStorage.instance.ref().child('uploads/$name');
    image = File(image1.path);
    final uploadTask = ref.putFile(image!);
    final taskSnapshot = await uploadTask.whenComplete(() {});
    url = await taskSnapshot.ref.getDownloadURL();
    print(url);
  }

  Widget buildButton() => ButtonWidget(
      text: 'Save',
      onClicked: () async {
        await UserSimplePreferences.setUser(user1);
        await UserSimplePreferences.setUsername(_call);
        await UserSimplePreferences.setLine(_txt);
        // await UserSimplePreferences.setBatch(batch);
        // await UserSimplePreferences.setSection(section);
        if (_formkey.currentState!.validate()) {
          List<String> dept = List.filled(11, 'null');
          dept[0] = 'BBA';
          dept[1] = 'CSE';
          dept[2] = 'English';
          dept[3] = 'EEE';
          dept[4] = 'Civil Engineering';
          dept[5] = 'Architecture';
          dept[6] = 'Law';
          dept[7] = 'Islamic Studies';
          dept[8] = 'Public Health';
          dept[9] = 'Tourism & Hospitality Management';
          dept[10] = 'Bangla';

          List<String> identity = List.filled(2, 'null');
          identity[0] = 'Student';
          identity[1] = 'Teacher';

          for (int i = 0; i < 11; i++) {
            String _dept = dept[i];
            for (int i = 0; i < 2; i++) {
              String _identity = identity[i];

              try {
                await FirebaseFirestore.instance
                    .collection(_dept)
                    .doc(_dept)
                    .collection(_identity)
                    .doc(user?.uid)
                    .update({
                  "mobile": _call,
                  "batch": deptselectedType,
                  "section": selectedType,
                  "about": _txt,
                  "cr": valuefirst,
                  "url": url,
                });
                Fluttertoast.showToast(msg: 'Your profile has been saved.');
              } catch (e) {
                print(e);
              }
            }
          }
        }
      });
}
