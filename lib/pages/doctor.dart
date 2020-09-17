import 'package:flutter/material.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project_doctor/services/constants.dart';
import 'package:project_doctor/pages/doctor_form.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

// initilize data from services
final AuthService _auth = AuthService();

// function created to make choices for the appbar 3dot menu
void choiceAction(String choice) async {
  if (choice == PopUpMenuConstants.logOut) {
    await _auth.signOut();
  } else {
    print('settings');
  }
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<DoctorInfo>>.value(
      value: DatabaseService().doctorInfo,
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Text(
              'معلومات الطبيب',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            centerTitle: true,
            elevation: 1,
            actions: [
              FlatButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return DoctorForm();
                      });
                },
                icon: Icon(Icons.settings),
                label: Text(''),
              ),
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
          body: DoctorList()),
    );
  }
}

// class continuation from above
class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    final doctorInfo = Provider.of<List<DoctorInfo>>(context) ?? [];

    return ListView.builder(
        itemCount: doctorInfo.length,
        itemBuilder: (BuildContext context, int index) {
          return DoctorTile(doctorInfo: doctorInfo[index]);
        });
  }
}

// a new statelessWidget to hold the Tile widget tree
class DoctorTile extends StatelessWidget {
  final DoctorInfo doctorInfo;
  DoctorTile({this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[100],
          ),
          title: Text(doctorInfo.name),
          subtitle: Text('Iam ${doctorInfo.speciality}'),
        ),
      ),
    ]);
  }
}
