import 'dart:convert';
import 'package:fyp_project_version3/pages/share/loading.dart';
import 'package:http/http.dart' as HTTP;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project_version3/bloc/main_bloc.dart';
import 'package:fyp_project_version3/route/route.dart';
import 'package:fyp_project_version3/pages/screen.dart';

class PageSignin extends StatefulWidget {
  @override
  _PageSigninState createState() => _PageSigninState();
}

class _PageSigninState extends State<PageSignin> {
  //variable to hold data textfield
  String dataEmail;
  String dataPassword;

  //! Variable >>> Form >>> Key 
  final formKey = GlobalKey<FormState>();

  //! Service >>> Show / Hide Password
  bool _obsecureText = true;
  passwordShowHide() {
    setState(() {
     _obsecureText = !_obsecureText; 
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 5,
                      child: Center(
                        child: Container(
                          width: 250,
                          child: Image.asset("assets/image_01.png", height: 180.0, width: 180.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom:10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         Text(
                            "Welcome to MRSM E-Wallet",
                            style: TextStyle(fontFamily: "Poppin-Bold", fontSize: 40.0, letterSpacing: 0.6, fontWeight: FontWeight.bold),
                         ),
                         SizedBox(
                           height: 6,
                         ),
                         Text(
                           "Login",
                           style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 45.0, letterSpacing: .6),
                         ),
                         SizedBox(
                           height: 40,
                         ),
                         Form(
                           key: formKey,
                           child: Column(
                             children: <Widget>[
                               TextFormField(
                                 validator: (value) {
                                   if (value.isEmpty) {
                                     return "Email cannot be empty!";
                                   } else {
                                     return null;
                                   }
                                 },
                                 onSaved: (e) => dataEmail = e,
                                 style: TextStyle(color: Colors.black, fontSize: 18),
                                 keyboardType: TextInputType.emailAddress,
                                 decoration: InputDecoration(
                                   prefixIcon: Icon(Icons.email), hintText: "Email Address", hintStyle: TextStyle(fontFamily: "Poppins-Bold", fontSize: 45.0, letterSpacing: .6),
                                 ),
                               ),
                               SizedBox(
                                 height: 15,
                               ),
                               TextFormField(
                                 validator: (value) {
                                   if (value.isEmpty) {
                                     return "Password must not be empty!";
                                   } else {
                                     return null;
                                   }
                                 },
                                 onSaved: (e) => dataPassword = e,
                                 obscureText: _obsecureText,
                                 style: TextStyle(color: Colors.black, fontSize: 18),
                                 decoration: InputDecoration(
                                   prefixIcon: IconButton(
                                     onPressed: passwordShowHide,
                                     icon: Icon(_obsecureText ? Icons.visibility_off : Icons.visibility),
                                   ),
                                   hintText: "Password",
                                   hintStyle: TextStyle(fontFamily: "Poppins-Bold", fontSize: 45.0, letterSpacing: .6),
                                 ),
                               ),
                               Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                   Text(
                                     "Forgot Password ?",
                                     style: TextStyle(color: Colors.white, fontFamily: "Poppins-Medium", fontSize: 28),
                                   ),
                                  ],
                               ),
                               SizedBox(
                                 height: 15,
                               ),
                               Container(
                                 width: double.infinity,
                                 child: RaisedButton(
                                   onPressed: () async {
                                     final form = formKey.currentState;
                                     if (form.validate()) {
                                       form.save();
                                       print("$dataEmail, $dataPassword");
                                       String url = "http:://10.0.2.2/fyp_project_api_version_1.0/api/student/studentsignin.php?" +
                                       "email=" +
                                       dataEmail +
                                       "&password=" +
                                       dataPassword;

                                       final response = await HTTP.post(url);

                                       final data = json.decode(response.body);

                                       print(data);

                                       if(data['status'] == true) {
                                         mainBloc.setuserid(data['userid'].toString());
                                         Navigator.pushNamed(context, routeGotoHomepage);
                                       } else {
                                         Navigator.pushNamed(context, routeGotoSignin);
                                       }
                                     }
                                   },
                                   child: Text(
                                     'Login',
                                     style: TextStyle(fontFamily:"Poppins-Medium", fontSize: 28 ),
                                   ),
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(5),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           height: 15,
                         ), 
                         Container(
                           width: double.infinity,
                           child: FlatButton(
                             onPressed: () {
                               Navigator.pushNamed(context, routeGotoSignup);
                             },
                             child: Text(
                               "New User ? SignUp",
                               style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold"),
                             ),
                           ),
                         ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget builLoading(){
    return ScreenLoading();
  }
}