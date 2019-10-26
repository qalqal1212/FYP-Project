import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:provider/provider.dart';
import 'package:fyp_project_version3/bloc/main_bloc.dart';
import 'package:fyp_project_version3/model/mymodel.dart';
 
class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String userid;

  List<HistoryPurchase> historyListPurchase = List<HistoryPurchase>();

  //Future History Purchase 
  Future<List<HistoryPurchase>> serviceHistoryPurchase() async {
    String url = "http://192.168.1.151/fyp_project_api_version_1.0/api/history/historypurchase.php?userid=" + userid;
    final response = await HTTP.get(url);
    final data = json.decode(response.body);

    data.forEach((object) {
      historyListPurchase.add(HistoryPurchase.fromJson(object));
    });

    return historyListPurchase;
  }

  Widget historyPurchase() {
    return FutureBuilder(
      future: serviceHistoryPurchase(),
      builder: (context, snapshot) {
        return ListView.separated(
          itemCount: historyListPurchase.length < 21 ? historyListPurchase.length : 20,
          itemBuilder: (context, snapshot) {
            return ListTile(
              title: Text("ID : ${historyListPurchase[snapshot].dataID}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              subtitle: Text("${historyListPurchase[snapshot].dataDateTime}"),
              trailing: Text(
                "RM ${historyListPurchase[snapshot].dataAmount}",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
                return Divider();
              }
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final MainBloc mainBloc = Provider.of<MainBloc>(context);
    userid = mainBloc.userid;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text ('History'),
          centerTitle: true,
          leading: Container(),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Purchase",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[historyPurchase()]
          ),
      ),
    );
  }
}