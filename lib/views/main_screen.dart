import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youngtech_test/views/drawer_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  String _token = "";
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
      print(_token);
    });
  }

  void test() async {
    http.Response response = await http.get(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type':
        'application/x-www-form-urlencoded; charset=UTF-8',
        'x-access-token' : _token
      },
    );
    print(response.body);
    print(_token);
  }

  Widget _test() {
    return ElevatedButton(
      child: const Text('test'),
      onPressed: () {
        test();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              //title: Text("Youngtech technical test"),
              //automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _test(),
                  ]
              ),
            )
        )
    );
  }
}
