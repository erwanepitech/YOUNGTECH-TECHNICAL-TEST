import 'package:youngtech_test/views/register_screen.dart';
import 'package:youngtech_test/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:youngtech_test/page/qr_code_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}