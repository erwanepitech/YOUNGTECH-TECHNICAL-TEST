import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youngtech_test/views/drawer_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  String _token = "";

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

            )
        )
    );
  }
}
