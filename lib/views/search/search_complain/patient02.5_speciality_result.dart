// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:project_doctor/services/theme.dart';
// import 'package:project_doctor/matching_algorithm/final_score.dart';
// import 'package:project_doctor/generated/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';


// class SpecialityResult extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: AppBar(
//           backgroundColor: Colors.deepOrange,
//           title: FittedBox(
//             fit: BoxFit.fitWidth,
//             child: Text(
//               AppLocalizations.of(context).translate('speciality_result'),
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0,
//         ),
//       ),
//       body: Center(
//         child: Container(
//           height: 100,
//           width: 100,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 decoration: boxDecoration,
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 100,
//                       child: Image(
//                         image: AssetImage('assets/images/speciality.png'),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     AutoSizeText(
//                       AppLocalizations.of(context).translate('result_speciality'),
//                       maxLines: 2,
//                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Divider(
//                       color: Colors.grey,
//                       thickness: 2,
//                       indent: 20,
//                       endIndent: 20,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Center(
//                       child: ListTile(
//                         leading: Icon(
//                           Icons.person_add,
//                           size: 40,
//                           color: Colors.deepOrangeAccent,
//                         ),
//                         title: FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Text(
//                             //FinalScore.speciality,
//                             AppLocalizations.of(context).translate(FinalScore.speciality) +
//                                 AppLocalizations.of(context).translate(FinalScore.or) +
//                                 AppLocalizations.of(context).translate(FinalScore.speciality2),
//                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 50,
//                 width: 150,
//                 child: TextButton.icon(
//                   style: TextButton.styleFrom(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
//                     backgroundColor: Colors.deepOrange,
//                   ),
//                   icon: Icon(
//                     Icons.arrow_forward,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/patient_get_location');
//                   },
//                   label: Text(
//                     LocaleKeys.view_buttons_next.tr(),
//                     style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }