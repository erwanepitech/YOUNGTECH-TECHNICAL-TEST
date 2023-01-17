import 'package:flutter/material.dart';
import 'package:youngtech_test/views/register_screen.dart';
import 'package:youngtech_test/views/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _login(BuildContext context) {
    return ElevatedButton(
      child: const Text('register'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
    );
  }

  Widget _register(BuildContext context) {
    return ElevatedButton(
      child: const Text('login'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Youngtech technical test'),
      ),
      body: Center(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _login(context),
                _register(context)
              ]),
        ),
      ),
    );
  }
}
