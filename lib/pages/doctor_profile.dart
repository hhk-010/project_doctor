import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/pages/updateinfo.dart';
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
            FlatButton(child: Text('update your info'),onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Updateinfo()));
            },),
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
      var uid =FirebaseAuth.instance.currentUser.uid ;


    final doctorListProvider = Provider.of<QuerySnapshot>(context);

    String name = '';
    String speciality = '';
    String number = '';
    String province = '';
    double lattt = 0.0;
    double lnggg = 0.0;

    for (var doc in doctorListProvider.docs) {
      if (doc.id == uid) {
        print(doc.data()['name']);
        name = doc.data()['name'];
        speciality = doc.data()['speciality'];
        number = doc.data()['phoneNumber'];
        province = doc.data()['province'];
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                speciality,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                number,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                province,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _DoctorListState extends State<DoctorList> {
//   @override
//   Widget build(BuildContext context) {
//     final doctorListProvider = Provider.of<QuerySnapshot>(context);

//     for (var doc in doctorListProvider.docs) {
//       print(doc.data());

//       return Container(
//         child: Column(
//           children: [
//             Text(''),
//           ],
//         ),
//       );
//     }
//   }
// }


