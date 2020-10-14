import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_doctor/authorization/email_verfication.dart';
import 'package:project_doctor/authorization/01_wrapper.dart';
import '../../services/auth.dart';

class DocMap extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String speciality;
  final String phone;
  final String province;

  DocMap(
      {this.email,
      this.password,
      this.name,
      this.speciality,
      this.phone,
      this.province});

  @override
  _DocMapState createState() => _DocMapState(
      email: email,
      password: password,
      name: name,
      speciality: speciality,
      phoneNumber: phone,
      province: province);
}

class _DocMapState extends State<DocMap> {
  final AuthService _auth = AuthService();

  var email;
  String password;
  var name;
  var speciality;
  var phoneNumber;
  var province;

  _DocMapState(
      {this.email,
      this.password,
      this.name,
      this.speciality,
      this.phoneNumber,
      this.province});
  String error = '';
  var latlng;

  List<Marker> mymarker = [];

  handletap(LatLng tappedpoint) {
    print(tappedpoint);

    latlng = tappedpoint.toString();

    setState(() {
      mymarker = [];
      mymarker.add(Marker(
        markerId: MarkerId(latlng),
        position: tappedpoint,
      ));
    });
  }

  double lattt;
  double lnggg;

  geolocate({String latlng}) {
    var firstindex = latlng.indexOf('(');
    var secondindex = latlng.indexOf(',');
    var thirdindex = latlng.indexOf(')');
    String lat = latlng.substring(firstindex + 1, secondindex);
    String lng = latlng.substring(secondindex + 1, thirdindex);

    lattt = double.parse(lat);
    lnggg = double.parse(lng);
  }

  //function to show a snackbar if the user didn't tap on the location
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final _snackBar = new SnackBar(
      content: Text(
        error,
        style: TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(_snackBar);
  }

  //==========================checking internet connection
  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
        setState(() {});
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
      setState(() {});
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Confirm Location',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(33.312805, 44.361488), zoom: 10),
            markers: Set.from(mymarker),
            onTap: handletap,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 15.0),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Text(
                'OK',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                checkInternet();
                if (_isInternet) {
                  if (latlng == null) {
                    error = 'Please , tap on your location';
                    _showSnackBar();
                  } else {
                    await geolocate(latlng: latlng);
                    if (lattt != null && lnggg != null) {
                      final result = await _auth.registerWithEmailAndPassword(
                          email,
                          password,
                          name,
                          speciality,
                          phoneNumber,
                          province,
                          lattt,
                          lnggg);
                      setState(() {
                        newclient.email = email;
                      });
                      //========Navigation to EmailVerification without the following
                      // condition is a bug(emails Already in use can navigate)
                      //------ direct navigation to the emailverfied widget will
                      // give a fake page (when pressing continue) it will not respond)
                      // I found put wrapper and transferred email by another method
                      if (result != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Intermediate(),
                          ),
                        );
                      } else {
                        setState(() {
                          error =
                              'Registeration error , please enter valid credentials';
                        });
                        _showSnackBar();
                      }
                    }
                  }
                } else {
                  setState(() {
                    error = 'No internet connection';
                  });
                }
                _showSnackBar();
              },
            ),
          ),
        ],
      ),
    );
  }
}
