import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fyp_project_version3/route/route.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project_version3/bloc/main_bloc.dart';
import 'package:http/http.dart' as HTTP;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userid;
  String dataCurrent;

  @override
  initState() {
    super.initState();
    dataCurrent = "";
  }

  //Show balance in account
  Future<dynamic> showCurrent() async {
    String url ="http://192.168.1.151/fyp_project_api_version_1.0/api/wallet/walletshow.php?userid=" + userid;
    final response = await HTTP.get(url);
    final data = json.decode(response.body);
    dataCurrent == "" ? dataCurrent = data["wallet"] : dataCurrent = dataCurrent;
    print(data['wallet']);

    //setState(() {
     // dataCurrent = data["wallet"];
   // });
  }

  //Scan QR Code
  String qrcode = "";
  serviceScan() async {
    final scan = await FlutterBarcodeScanner.scanBarcode("#004297", "CANCEL", false, ScanMode.QR);

    String url = "http://192.168.1.151/fyp_project_api_version_1.0/api?" + userid + scan;

    final response = await HTTP.post(url);

    final data = json.decode(response.body);

    print(scan);

    if(data['status'] == true) {
      Navigator.pushNamed(context, routeGotoHomepage);
    } else {
      Navigator.pushNamed(context, routeGotoSignin);
    }
  }

  //Service >> Purchase
   servicePurchase() async {
     serviceScan();

    String url = "http://192.168.1.151/fyp_project_api_version_1.0/api/wallet/walletshow.php?userid=" + userid + "&" + qrcode;

     final response = await HTTP.get(url);
     final data = json.decode(response.body);


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
          fit: StackFit.expand,
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
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                        "MRSM E-Wallet",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: 25.0,
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Row(
                      children: <Widget>[
                        Text(
                          "Your Balance is:",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: 18.0,
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder(
                          future: showCurrent(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
                              return CircularProgressIndicator();
                            } else {
                              return LimitedBox(
                                maxWidth: 150,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "RM ",
                                      style: TextStyle(
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18.0,
                                        letterSpacing: .6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "$dataCurrent",
                                      style: TextStyle(
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18.0,
                                        letterSpacing: .6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 75.0,
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Image.asset("assets/image_03.png",
                                    height: 140, width: 120),
                                Image.asset("assets/image_04.png",
                                    height: 140, width: 120)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                InkWell(
                                  onTap: servicePurchase, 
                                    //Navigator.pushNamed(context, routeGotoScanQR);
                                  child: Text("Scan to Pay",
                                  textAlign: TextAlign.center, style: TextStyle(
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 20.0
                                  )),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, routeGotoHistory);
                                  },
                                  child: Text("History",
                                  textAlign: TextAlign.center, style: TextStyle(
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 20.0
                                  )
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Image.asset("assets/image_05.png",
                                    height: 140, width: 120),
                                Image.asset("assets/image_06.png",
                                    height: 140, width: 120)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, routeGotoProfile);
                                  },
                                  child: Text("Manage Profile",
                                  textAlign: TextAlign.center, style: TextStyle(
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 20.0
                                  )),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, routeGotoReload);
                                  },
                                  child: Text("Reload",
                                  textAlign: TextAlign.center, style: TextStyle(
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 20.0
                                  )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
