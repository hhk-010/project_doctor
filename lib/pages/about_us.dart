import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_doctor/services/app_localizations.dart';

class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            AppLocalizations.of(context).translate('about_us'),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 25, 50, 25),
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 250,
                child: Image(
                  image: AssetImage('assets/images/about_us.png'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  'Purpose',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                color: Colors.deepOrange,
                thickness: 3,
                indent: 30,
                endIndent: 30,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'This app is made with the purpose of simplifying process of choosing the right doctor for the patient Complain',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Developers',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.deepOrange,
                thickness: 3,
                indent: 30,
                endIndent: 30,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent,
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/register.png'),
                ),
                title: Text(
                  'Ahmed Abdul Wahid',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'M.B.CH.B\nLead Programmer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Divider(
                color: Colors.deepOrange,
                thickness: 3,
                indent: 30,
                endIndent: 30,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent,
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/register.png'),
                ),
                title: Text(
                  'HHK',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  'M.B.CH.B\nUI/UX Programmer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
