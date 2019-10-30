import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:provider/provider.dart';
import 'package:fyp_project_version3/bloc/main_bloc.dart';
import 'package:fyp_project_version3/route/route.dart';
import 'package:fyp_project_version3/model/mymodel.dart';

 
class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  //Variable to Hold Data from TextField
  String userid;
  var holdEmail;
  var holdPassword;
  var holdfname;
  var holdlname;
  var holdnoic;

  //variable >>> form >> key 
  final formKey = GlobalKey<FormState>();

  //future >>> show current balance 
  Future profileGet() async {
    String url = "http://10.59.39.107/fyp_project_api_version_1.0/api/profile/profilesingle.php?userid=" + userid;
    final response = await HTTP.get(url);
    final data = json.decode(response.body);

    holdEmail != "" ? holdEmail = data["email"] : holdEmail = holdEmail;
    holdPassword != "" ? holdPassword = data["password"] : holdPassword = holdPassword;
    holdfname != "" ? holdfname = data["fname"] : holdfname = holdfname;
    holdlname != "" ? holdlname = data["lname"] : holdlname = holdlname;
    holdnoic != "" ? holdnoic = data["noIC"] : holdnoic = holdnoic;

  }

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    userid = mainBloc.userid;

    return Scaffold(
      backgroundColor: Colors.orange,
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Stack(
          //fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset("assets/image_01.png",
                      height: 180.0, width: 170.0),
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset("assets/image_02.png"),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0, bottom: 300.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                        "MRSM E-Wallet",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 25.0,
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                        "Update Profile",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 25.0,
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                      FutureBuilder(
                        future: profileGet(),
                        builder: (context, snapshot) {
                          return Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Primary Details',
                                    style: TextStyle(
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 25.0,
                                      letterSpacing: .6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: TextEditingController(text: holdEmail.toString()),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Email must not be empty!";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) => holdEmail = value,
                                  decoration: InputDecoration(hintText: "Email Address"),
                                ),
                                SizedBox(
                                  height: 10
                                ),
                                TextFormField(
                                  controller: TextEditingController(text: holdPassword.toString()),
                                  validator: (value) {
                                     if (value.isEmpty) {
                                      return "Password cannot be empty!";
                                    } else {
                                      return null;
                                     }
                                  },
                                  onSaved: (value) => holdPassword = value,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                  hintText: 'Password',
                                    ),
                                  ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: Text(
                                    'Primary Detail',
                                    style: TextStyle(
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 25.0,
                                      letterSpacing: .6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                               TextFormField(
                                 controller: TextEditingController(text: holdfname.toString()),
                                 validator: (value) {
                                   if (value.isEmpty) {
                                     return "First Name must not be empty!";
                                   } else {
                                     return null;
                                   }
                                 },
                                 onSaved: (value) => holdfname = value,
                                 decoration: InputDecoration(hintText: "First Name"),
                               ),
                               SizedBox(
                                 height: 10.0,
                               ),
                               TextFormField(
                                 controller: TextEditingController(text: holdlname.toString()),
                                 validator: (value) {
                                   if (value.isEmpty) {
                                     return "Last Name must not be empty!";
                                   } else {
                                     return null;
                                   }
                                 },
                                 onSaved: (value) => holdlname = value,
                                 decoration: InputDecoration(hintText: "Last Name"),
                               ),
                               SizedBox(
                                 height: 10.0,
                               ),
                               TextFormField(
                                 controller: TextEditingController(text: holdnoic.toString()),
                                 validator: (value) {
                                   if (value.isEmpty) {
                                     return "IC Number must not be empty!";
                                   } else {
                                     return null;
                                   }
                                 },
                                 onSaved: (value) => holdnoic = value,
                                 decoration: InputDecoration(hintText: "IC Number"),
                               ),
                               SizedBox(
                                 height: 10.0,
                               ),
                               MaterialButton(
                                 onPressed: () {
                                   Navigator.pop(context);
                                 },
                                 child: Text(
                                   'Cancel',
                                 ),
                                 color: Colors.orange[500],
                                 minWidth: double.infinity,
                                 height: 50,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                               ),
                               SizedBox(
                                 height: 10,
                               ),
                               MaterialButton(
                                 onPressed: () async {
                                  final form = formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    String url = "http://10.59.39.107/fyp_project_api_version_1.0/api/profile/profileupdate.php?userid=" +
                                    userid +
                                    "&email=" +
                                    holdEmail +
                                    "&password=" +
                                    holdPassword +
                                    "&fname=" +
                                    holdfname +
                                    "&lname=" +
                                    holdlname +
                                    "&noIC=" +
                                    holdnoic;

                                    final response = await HTTP.put(url);

                                    final data = json.decode(response.body);

                                    print(data);

                                    if (data['message'] == "Profile was updated.") {
                                      Navigator.pushNamed(context, routeGotoHomepage);
                                    } else {}
                                  } 
                                 },
                                 child: Text(
                                   'Update',
                                 ),
                                 color: Colors.orange[500],
                                 minWidth: double.infinity,
                                 height: 50.0,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                               ), 
                               SizedBox(
                                 height: 10.0,
                               ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}