import 'package:flutter/material.dart';
import 'package:project_doctor/auth/authenticate.dart';
import 'package:project_doctor/pages/doctor_update.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return DoctorUpdate();
    }
  }
}
