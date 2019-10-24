import 'package:flutter/material.dart';
 
class MainBloc extends ChangeNotifier{
  String _userid;

  String get userid => _userid;

  set userid(String dataId){
    _userid = dataId;
    notifyListeners();
  }

  setuserid(String dataId){
    _userid = dataId;
    notifyListeners();
  }

  myuserid(){
    userid;
  }

}