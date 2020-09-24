import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/services/theme_const.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';

class DoctorProfile extends StatelessWidget {
  final AuthService _auth = AuthService();
  void choiceAction(String choice) async {
    if (choice == PopUpMenuConstants.logOut) {
      await _auth.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().doctorDataProfileStream,
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
        body: DoctorList(),
      ),
    );
  }
}

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    final doctorListProvider = Provider.of<QuerySnapshot>(context);

    for (var doc in doctorListProvider.docs) {
      print(doc.data());

      return Container(
        child: Column(
          children: [
            Text(''),
          ],
        ),
      );
    }
  }
}
