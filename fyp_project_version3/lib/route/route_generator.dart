import 'package:flutter/material.dart';
import 'package:fyp_project_version3/pages/auth/auth_sigin2.dart';
import 'package:fyp_project_version3/pages/history.dart';
import 'package:fyp_project_version3/pages/qrscan.dart';
import 'package:fyp_project_version3/pages/reload.dart';
import 'package:fyp_project_version3/pages/updateProfile.dart';
import 'package:fyp_project_version3/route/route.dart';
import 'package:fyp_project_version3/pages/screen.dart';


Route<dynamic> routeGenerator(RouteSettings settings) {
  switch (settings.name) {
    case routeGotoSignin:
    return MaterialPageRoute(builder: (context) => Sign());

    case routeGotoHomepage:
    return MaterialPageRoute(builder: (context) => HomePage());

    case routeGotoSignup:
    return MaterialPageRoute(builder: (context) => Signup());

    case routeGotoScanQR:
    return MaterialPageRoute(builder: (context) => QRscan());

    case routeGotoHistory:
    return MaterialPageRoute(builder: (context) => HistoryPage());

    case routeGotoReload:
    return MaterialPageRoute(builder: (context) => ReloadPage());

    case routeGotoProfile:
    return MaterialPageRoute(builder: (context) => UpdateProfilePage());

    default:
    return MaterialPageRoute(builder: (context) => HomePage());
  }
}