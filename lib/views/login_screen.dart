import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenScreenState();
  }
}

class LoginScreenScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";
  bool _isHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final uri = 'http://10.0.2.2:8080/api/auth/signin';

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

  void _sendForm() async {
    var map = new Map<String, dynamic>();
    map['username'] = _username;
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
      print(jsonDecode(response.body));
    } else {
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildPassword(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print(_username);
                      print(_password);

                      _sendForm();
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
