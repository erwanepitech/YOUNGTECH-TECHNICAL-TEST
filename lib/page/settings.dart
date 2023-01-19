import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youngtech_test/views/home_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
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

  Future<void> _buildlogout() async {
    final prefs = await SharedPreferences.getInstance();
    if (_token != "") {
      prefs.remove('token');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  Widget _logout(BuildContext context) {
    return ElevatedButton(
      child: const Text('logout'),
      onPressed: () {
        _buildlogout();
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        //title: Text("Youngtech technical test"),
        //automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _logout(context),
            ]
        ),
      )
  );
}
