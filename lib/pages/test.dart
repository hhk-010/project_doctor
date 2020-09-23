import 'package:flutter/material.dart';
import 'package:project_doctor/services/auth.dart';

class Testing extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
        centerTitle: true,
        actions: [
          RaisedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text('log out'),
          ),
        ],
      ),
      body: Text(
        'Testing Auth',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
