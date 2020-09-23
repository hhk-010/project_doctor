import 'package:flutter/material.dart';
import 'package:project_doctor/services/theme_const.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class DoctorInfo extends StatelessWidget {
  final AuthService _auth = AuthService();
  void choiceAction(String choice) async {
    if (choice == PopUpMenuConstants.logOut) {
      await _auth.signOut();
    } else {
      print('settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<DoctorDataListModel>>.value(
      value: DatabaseService().doctorDataStream,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          title: Text(
            'Your Information',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          elevation: 1,
          actions: [
            PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return PopUpMenuConstants.choices.map((String choice) {
                    return PopupMenuItem(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                }),
          ],
        ),
        body: InfoList(),
      ),
    );
  }
}

class InfoList extends StatefulWidget {
  @override
  _InfoListState createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {
  @override
  Widget build(BuildContext context) {
    final doctorListProvider = Provider.of<List<DoctorDataListModel>>(context);

    doctorListProvider.forEach((element) {
      print(element.name);
      print(element.speciality);
      print(element.phoneNumber);
    });

    return ListView(
      children: [],
    );
  }
}
