import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';

class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;

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
        padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
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
                height: 15,
              ),
              Center(
                child: Text(
                  'Purpose',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "This app is made with the purpose of simplifying process of choosing the right doctor for the patient's Complain.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'Developers',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/ahmed.png'),
                        ),
                        title: Text(
                          'Ahmed Khagani',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigoAccent,
                                fontFamily:
                                    lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'M.B.CH.B\n',
                                  style: TextStyle(color: Colors.redAccent)),
                              TextSpan(
                                  text: 'Lead Programmer', style: TextStyle()),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/hhk.png'),
                        ),
                        title: Text(
                          'HHK',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigoAccent,
                                fontFamily:
                                    lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'M.B.CH.B\n',
                                  style: TextStyle(color: Colors.redAccent)),
                              TextSpan(
                                  text: 'UI/UX Programmer', style: TextStyle()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'This app is developed using the following:',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: boxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image(
                          image: AssetImage('assets/images/windows.png'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image(
                          image: AssetImage('assets/images/flutter.png'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image(
                          image: AssetImage('assets/images/dart.png'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image(
                          image: AssetImage('assets/images/VScode.png'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image(
                          image: AssetImage('assets/images/firebase.png'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image(
                          image: AssetImage('assets/images/google_map.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    Text(
                      '© 2020 Cura Team. All Rights Reserved.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
