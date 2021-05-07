// import 'dart:collection';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:project_doctor/generated/locale_keys.g.dart';
// import 'package:project_doctor/views/patient_pages/patient03_get_location.dart';
// import 'package:easy_localization/easy_localization.dart';

// //this file is to show the location of the doctor on the map to the patient

// class PatientResultMap extends StatefulWidget {
//   final double lat;
//   final double lng;
//   PatientResultMap({this.lat, this.lng});
//   @override
//   _PatientResultMapState createState() => _PatientResultMapState(lat: lat, lng: lng);
// }

// class _PatientResultMapState extends State<PatientResultMap> {
//   double lat;
//   double lng;
//   _PatientResultMapState({this.lat, this.lng});
//   Set<Marker> _marker = HashSet<Marker>();
//   // ignore: unused_field
//   GoogleMapController _mapController;
//   void _onmapcreated(GoogleMapController controller) {
//     _mapController = controller;
//     setState(() {
//       _marker.add(Marker(markerId: MarkerId('0'), position: LatLng(lat, lng)));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: AppBar(
//           backgroundColor: Colors.deepOrange,
//           title: FittedBox(
//               fit: BoxFit.fitWidth,
//               child: Text(
//                                              LocaleKeys.view_patient_doctor_location.tr(),

//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               )),
//           centerTitle: true,
//           elevation: 0,
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onmapcreated,
//             initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 10),
//             markers: _marker,
//             zoomControlsEnabled: false,
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 25.0),
//             alignment: Alignment.bottomCenter,
//             child: FloatingActionButton(
//               backgroundColor: Colors.deepOrange,
//               child: Text(
//                 LocaleKeys.view_buttons_ok.tr(),
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               onPressed: () {
//                 int count = 0;
//                 Navigator.popUntil(context, (route) => MyVariables.usingMap ? count++ == 7 : count++ == 6);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
