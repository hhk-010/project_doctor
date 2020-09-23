import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_doctor/services/theme_const.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60.0,
                  width: 300.0,
                  child: RaisedButton(
                    onPressed: () => Navigator.pushNamed(context, '/patient'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: boxDecoration,
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          ' انا مريض واريد البحث عن طبيب',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'noto_arabic',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  height: 60.0,
                  width: 350.0,
                  child: RaisedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/intermediate'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: boxDecoration,
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          'انا طبيب واريد التسجيل في التطبيق',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
