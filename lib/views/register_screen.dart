import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youngtech_test/views/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  String _username = "";
  String _email = "";
  String _password = "";
  bool _isHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final uri = 'http://10.0.2.2:8080/api/auth/signup';

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Username'),
      maxLength: 10,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _username = value.toString();
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is Required';
        }
        String pattern = r'\w+@\w+\.\w+';
        if (!RegExp(pattern).hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (value) {
        _email = value.toString();
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: _isHidden,
      decoration: InputDecoration(
        labelText: 'Password',
        suffix: InkWell(
          onTap: _togglePasswordView,
          child: Icon(Icons.visibility),
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is Required';
        }
        return null;
      },
      onSaved: (value) {
        _password = value.toString();
      },
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _sendForm(BuildContext context) async {
    var map = new Map<String, dynamic>();
    map['username'] = _username;
    map['email'] = _email;
    map['password'] = _password;

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type':
        'application/x-www-form-urlencoded; charset=UTF-8',
      },
      body: map,
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else if (response.statusCode == 404) {
      Map<String, dynamic> map = jsonDecode(response.body);
      map['error'] = "error";
      map['content'] = map['message'];
      _showDialog(context, map);
    } else if (response.statusCode == 401) {
      Map<String, dynamic> map = jsonDecode(response.body);
      map['error'] = "error";
      map['content'] = map['message'];
      _showDialog(context, map);
    } else {
      map['error'] = "error";
      map['content'] = "sorry try again later";
      _showDialog(context, map);
    }
  }

  void _showDialog(BuildContext context, Map map) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(map["error"]),
            content: Text(map["content"]),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildEmail(),
                _buildPassword(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(_username);
                      print(_email);
                      print(_password);

                      _sendForm(context);
                    }
                    //Send to API
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
