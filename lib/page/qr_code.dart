import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youngtech_test/views/drawer_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QrCodeScreenState();
  }
}

class QrCodeScreenState extends State<QrCodeScreen> {
  String _token = "";
  String _id = "";
  final uri = 'http://10.0.2.2:8080/api/user';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token').toString();
      getId();
    });
  }

  void getId() async {
    http.Response response = await http.get(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'x-access-token': _token
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data["id"].toString());
    _id = data["id"].toString();
    print(_token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("My Qr code"),
            //automaticallyImplyLeading: false,
            ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                QrImage(
                  data: 'http://10.0.2.2:8080/api/user/$_id',
                  version: QrVersions.auto,
                  size: 320,
                  gapless: false,
                )
              ]
          ),
        )
    );
  }
}
