import 'package:flutter/material.dart';
import 'package:project_doctor/auth/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/auth.dart';

//intermediate page created to solve the prolbem of the streamprovider.
class Intermediate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserID>.value(
      value: AuthService().user,
      child: Wrapper(),
    );
  }
}
