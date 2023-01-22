import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String result = "";
  String _token = "";

  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token').toString();
    });
  }

  void _showDialog(BuildContext context, Map map) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(map["message"]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(map["username"]),
                Text(map["email"]),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void getData(result) async {
    http.Response response = await http.get(
      Uri.parse(result),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'x-access-token': _token
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // to do redirect to qrcode scan page
      data['message'] = "success";
      data['username'] = data['username'];
      data['email'] = data['email'];
      _showDialog(context, data);
    } else if (response.statusCode == 404) {
      data['message'] = "error";
      data['content'] = data['message'];
      _showDialog(context, data);
    } else if (response.statusCode == 401) {
      data['message'] = "error";
      data['content'] = data['message'];
      _showDialog(context, data);
    } else {
      data['message'] = "error";
      data['content'] = "sorry try again later";
      _showDialog(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: (result != "")
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              textStyle: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          child: Text(
                            'get result',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            getData(result);
                            //Send to API
                          },
                        ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        child: Text(
                          're scan',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          setState(() {
                            result = "";
                          });
                        },
                      )
                      ])
                : Text('Scan a code'),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code.toString();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
