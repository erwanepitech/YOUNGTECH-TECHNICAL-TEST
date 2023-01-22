import 'package:flutter/material.dart';
import 'package:youngtech_test/page/settings.dart';
import 'package:youngtech_test/page/qr_code.dart';
import 'package:youngtech_test/page/qr_code_scanner.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);
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
            leading: Icon(Icons.qr_code_scanner),
            title: Text('Scan Qr-code'),
            onTap: () => { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScannerScreen()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.qr_code_2),
            title: Text('My Qr-code'),
            onTap: () => { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QrCodeScreen()),
            )},
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