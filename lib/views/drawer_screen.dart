import 'package:flutter/material.dart';
import 'package:youngtech_test/page/settings.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Youngtech technical test",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => { Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
            )},
          ),
        ],
      ),
    );
  }
}