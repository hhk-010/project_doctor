import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Home Screen Options'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/patient');
              },
              padding: EdgeInsets.all(0.0),
              child: Text(
                'Iam a Patient',
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
            ),
            Text(
              'i want to search for a doctor',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 100),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/doctor');
              },
              textColor: Colors.black,
              padding: EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                child: Text(
                  'Iam a doctor',
                  style: TextStyle(
                    fontSize: 50.0,
                  ),

                ),
              ),
            ),
          Text(
              'i want to Register my data',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),


          ],
        ),
      ),
    );
  }
}

