// import 'dart:convert';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:project_doctor/constants/color_style_size.dart';
// import 'package:project_doctor/generated/locale_keys.g.dart';
// import 'package:project_doctor/services/data_model.dart';
// import 'package:project_doctor/services/database.dart';
// import 'package:project_doctor/views/favorite_list/favorite_list.dart';
// import 'package:project_doctor/views/last_searched/read_write_path.dart';
// import 'package:provider/provider.dart';
// import 'package:easy_localization/easy_localization.dart';

// class SearchListView extends StatefulWidget {
//   @override
//   _SearchListViewState createState() => _SearchListViewState();
// }

// class _SearchListViewState extends State<SearchListView> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<QuerySnapshot>.value(
//       value: DatabaseService().usersDataStream,
//       initialData: null,
//       child: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(
//             getDeviceType(context, 36, 56, 56, 56),
//           ),
//           child: AppBar(
//             backgroundColor: Colors.deepOrange,
//             title: Text(
//               AppLocalizations.of(context).translate('search result'),
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontSize: getDeviceType(context, 16, 25, 35, 45),
//               ),
//             ),
//             centerTitle: true,
//             iconTheme: IconThemeData(
//               color: Colors.white,
//             ),
//           ),
//         ),
//         body: ResultList(),
//       ),
//     );
//   }
// }

// class ResultList extends StatefulWidget {
//   @override
//   _ResultListState createState() => _ResultListState();
// }

// class _ResultListState extends State<ResultList> {
//   List newList = [];
//   double nameScoreResult = 0;
//   getNameScore(String name1) {
//     String name2 = NewSearchData.name;
//     List name1list = [];
//     List name2list = [];

//     int name1l = name1.length;
//     int name2l = name2.length;
//     int name1c = 0;
//     int name2c = 0;
//     while (name1l > 0) {
//       name1list.add(name1.substring(name1c, name1c + 1));
//       name1c++;
//       name1l--;
//     }
//     while (name2l > 0) {
//       name2list.add(name2.substring(name2c, name2c + 1));
//       name2c++;
//       name2l--;
//     }
//     int list1l = name1list.length;
//     int list2l = name2list.length;
//     int denom = list1l;
//     int list1c = 0;
//     int score = 0;
//     while (list1l > 0 && list2l > 0) {
//       if (name1list[list1c] == name2list[list1c]) {
//         score++;
//       }
//       list1c++;
//       list1l--;
//       list2l--;
//     }
//     nameScoreResult = score / denom;
//     nameScoreResult = nameScoreResult * 100;
//   }

//   @override
//   void initState() {
//     super.initState();
//     DatabaseService.province = NewSearchData.province;
//   }

//   @override
//   Widget build(BuildContext context) {
//     newList = [];
//     final streamData = Provider.of<QuerySnapshot>(context);
//     if (streamData != null) {
//       for (var doc in streamData.docs) {
//         //if (NewSearchData.nameSelected) {
//         getNameScore(doc.data()['name']);
//         if (nameScoreResult > 40) {
//           newList.add(
//             NewSearchListData(
//                 id: doc.id,
//                 name: doc.data()['name'],
//                 speciality: doc.data()['speciality'],
//                 province: doc.data()['province'],
//                 phoneNumber: doc.data()['phoneNumber'],
//                 address: doc.data()['address'],
//                 lat: doc.data()['lat'],
//                 lng: doc.data()['lng'],
//                 workDays01: doc.data()['workDays01'],
//                 workDays02: doc.data()['workDays02'],
//                 workDays03: doc.data()['workDays03']),
//           );
//           nameScoreResult = 0;
//         }
//         //} else {
//         if (NewSearchData.speciality == doc.data()['speciality']) {
//           newList.add(
//             NewSearchListData(
//                 id: doc.id,
//                 name: doc.data()['name'],
//                 speciality: doc.data()['speciality'],
//                 province: doc.data()['province'],
//                 phoneNumber: doc.data()['phoneNumber'],
//                 address: doc.data()['address'],
//                 lat: doc.data()['lat'],
//                 lng: doc.data()['lng'],
//                 workDays01: doc.data()['workDays01'],
//                 workDays02: doc.data()['workDays02'],
//                 workDays03: doc.data()['workDays03']),
//           );
//         }
//         //}
//       }
//     }
//     return ListView.builder(
//       itemCount: streamData != null
//           ? newList.length != 0
//               ? newList.length > 10
//                   ? 10
//                   : newList.length
//               : 1
//           : 1,
//       itemBuilder: (context, index) {
//         return SearchListTile(
//           searchResultList: streamData != null
//               ? newList.length != 0
//                   ? newList[index]
//                   : NewSearchListData(name: 'Estate', speciality: 'O', address: 'District')
//               : NewSearchListData(name: 'Estate', speciality: 'Offer', address: 'District'),
//         );
//       },
//     );
//   }
// }

// class SearchListTile extends StatefulWidget {
//   final NewSearchListData searchResultList;
//   SearchListTile({this.searchResultList});
//   final LastSearchedStorage storage = LastSearchedStorage();
//   @override
//   _SearchListTileState createState() => _SearchListTileState();
// }

// class _SearchListTileState extends State<SearchListTile> {
//   String name = '';
//   String speciality = '';
//   String province = '';
//   String district = '';
//   String phoneNumber = '';
//   String lat = '';
//   String lng = '';
//   String workDays01 = '';
//   String workDays02 = '';
//   String workDays03 = '';

//   List workDays1 = [];
//   List workDays2 = [];
//   List workDays3 = [];

//   String _mainfrom = '';
//   String _mainTo = '';
//   String _mainfromTime = '';
//   String _mainfromAmPm = '';
//   String _mainToTime = '';
//   String _mainToAmPm = '';
//   String _mainTime = '';

//   String _firstfrom = '';
//   String _firstTo = '';
//   String _firstfromTime = '';
//   String _firstToTime = '';
//   String _firstfromAmPm = '';
//   String _firstToAmPm = '';

//   String _secondfrom = '';
//   String _secondTo = '';
//   String _secondfromTime = '';
//   String _secondToTime = '';
//   String _secondfromAmPm = '';
//   String _secondToAmPm = '';

//   Future<File> _writeName(value) {
//     setState(() => name = value);
//     return widget.storage.writeName(name);
//   }

//   Future<File> _writeSpeciality(value) {
//     setState(() => speciality = value);
//     return widget.storage.writeSpeciality(speciality);
//   }

//   Future<File> _writeAddress(value) {
//     setState(() => district = value);
//     return widget.storage.writeAddress(district);
//   }

//   Future<File> _writeProvince(value) {
//     setState(() => province = value);
//     return widget.storage.writeProvince(province);
//   }

//   Future<File> _writePhoneNumber(value) {
//     setState(() => phoneNumber = value);
//     return widget.storage.writeNumber(phoneNumber);
//   }

//   Future<File> _writeLat(value) {
//     setState(() => lat = value);
//     return widget.storage.writeLat(lat);
//   }

//   Future<File> _writeLng(value) {
//     setState(() => lng = value);
//     return widget.storage.writeLng(lng);
//   }

//   Future<File> _writeworkDays01(value) {
//     setState(() => workDays01 = value);
//     return widget.storage.writeWork01(workDays01);
//   }

//   Future<File> _writeWorkDays02(value) {
//     setState(() => workDays02 = value);
//     return widget.storage.writeWork02(workDays02);
//   }

//   Future<File> _writeWorkDays03(value) {
//     setState(() => workDays03 = value);
//     return widget.storage.writeWork03(workDays03);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: getDeviceType(context, 5, 10, 15, 20),
//         vertical: getDeviceType(context, 10, 20, 15, 20),
//       ),
//       child: widget.searchResultList.name == 'Estate'
//           ? widget.searchResultList.speciality == 'O'
//               ? Column(
//                   children: [
//                     SizedBox(
//                       height: getDeviceType(context, 20, 40, 60, 80),
//                     ),
//                     Center(
//                       child: Text(
//                        LocaleKeys.view_favorite_list_empty_list.tr(),
//                         style: TextStyle(
//                           fontSize: getDeviceType(context, 12, 15, 30, 30),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: getDeviceType(context, 20, 40, 60, 80),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.pushNamed(context, '/search listview');
//                       },
//                       icon: Icon(
//                         Icons.replay_rounded,
//                         color: Colors.black,
//                       ),
//                     )
//                   ],
//                 )
//               : Center(
//                   child: SpinKitRing(
//                     color: Colors.deepOrange,
//                   ),
//                 )
//           : Card(
//               margin: EdgeInsets.fromLTRB(
//                 getDeviceType(context, 1, 2, 8, 10),
//                 getDeviceType(context, 1, 2, 8, 10),
//                 getDeviceType(context, 1, 2, 8, 10),
//                 getDeviceType(context, 1, 2, 8, 10),
//               ),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   radius: getDeviceType(context, 20, 25, 30, 35),
//                   backgroundColor: Colors.deepOrange,
//                 ),
//                 title: Text(
//                   widget.searchResultList.name,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   AppLocalizations.of(context).translate(widget.searchResultList.speciality),
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 onTap: () {
//                   setState(() => FavoriteTile.favoriteListSelected = false);
//                   _writeName(widget.searchResultList.name);
//                   _writeAddress(widget.searchResultList.address);
//                   _writeSpeciality(widget.searchResultList.speciality);
//                   _writeProvince(widget.searchResultList.province);
//                   _writePhoneNumber(widget.searchResultList.phoneNumber);
//                   _writeLat(widget.searchResultList.lat.toString());
//                   _writeLng(widget.searchResultList.lng.toString());
//                   _writeworkDays01(json.encode(widget.searchResultList.workDays01));
//                   _writeWorkDays02(json.encode(widget.searchResultList.workDays02));
//                   _writeWorkDays03(json.encode(widget.searchResultList.workDays03));
//                   SearchResultData.id = widget.searchResultList.id;
//                   SearchResultData.name = widget.searchResultList.name;
//                   SearchResultData.speciality = widget.searchResultList.speciality;
//                   SearchResultData.address = widget.searchResultList.address;
//                   SearchResultData.province = widget.searchResultList.province;
//                   SearchResultData.phoneNumber = widget.searchResultList.phoneNumber;
//                   SearchResultData.lat = widget.searchResultList.lat;
//                   SearchResultData.lng = widget.searchResultList.lng;
//                   workDays1 = widget.searchResultList.workDays01;
//                   workDays2 = widget.searchResultList.workDays02;
//                   workDays3 = widget.searchResultList.workDays03;
//                   SearchResultData.workDays01 = [];

//                   for (String day in workDays1) {
//                     if (day != null) {
//                       if (day.length < 12) {
//                         SearchResultData.workDays01.add(AppLocalizations.of(context).translate(day));
//                       } else {
//                         _mainfrom = day.substring(day.indexOf('m') + 2, day.indexOf('t') - 1);
//                         _mainTo = day.substring(day.indexOf('t') + 3, day.length);
//                         _mainfromTime = _mainfrom.substring(0, _mainfrom.indexOf(' '));
//                         _mainfromAmPm =
//                             AppLocalizations.of(context).translate(_mainfrom.substring(_mainfrom.indexOf(' ') + 1, _mainfrom.indexOf('M') + 1));
//                         _mainToTime = _mainTo.substring(0, _mainTo.indexOf(' '));
//                         _mainToAmPm = AppLocalizations.of(context).translate(_mainTo.substring(_mainTo.indexOf(' ') + 1, _mainTo.length));
//                         _mainTime = LocaleKeys.view_time_day_from.tr() +
//                             _mainfromTime +
//                             ' ' +
//                             _mainfromAmPm +
//                             ' ' +
//                             LocaleKeys.view_time_day_to.tr() +
//                             _mainToTime +
//                             ' ' +
//                             _mainToAmPm;
//                         SearchResultData.workDays01.add(_mainTime);
//                       }
//                     }
//                   }
//                   if (workDays2.isNotEmpty && workDays2.length == 2) {
//                     SearchResultData.firstDay = AppLocalizations.of(context).translate(workDays2[0]);
//                     _firstfrom = workDays2[1].substring(workDays2[1].indexOf('m') + 2, workDays2[1].indexOf('t') - 1);
//                     _firstTo = workDays2[1].substring(workDays2[1].indexOf('t') + 3, workDays2[1].length);
//                     _firstfromTime = _firstfrom.substring(0, _firstfrom.indexOf(' '));
//                     _firstfromAmPm = AppLocalizations.of(context).translate(_firstfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length));
//                     _firstToTime = _firstTo.substring(0, _firstTo.indexOf(' '));
//                     _firstToAmPm = AppLocalizations.of(context).translate(_firstTo.substring(_firstTo.indexOf(' ') + 1, _firstTo.length));
//                     SearchResultData.firstTime = LocaleKeys.view_time_day_from.tr() +
//                         _firstfromTime +
//                         ' ' +
//                         _firstfromAmPm +
//                         ' ' +
//                         LocaleKeys.view_time_day_to.tr() +
//                         _firstToTime +
//                         ' ' +
//                         _firstToAmPm;
//                   }
//                   if (workDays3.isNotEmpty && workDays3.length == 2) {
//                     SearchResultData.secondDay = AppLocalizations.of(context).translate(workDays3[0]);
//                     _secondfrom = workDays3[1].substring(workDays3[1].indexOf('m') + 2, workDays3[1].indexOf('t') - 1);
//                     _secondTo = workDays3[1].substring(workDays3[1].indexOf('t') + 3, workDays3[1].length);
//                     _secondfromTime = _secondfrom.substring(0, _secondfrom.indexOf(' '));
//                     _secondfromAmPm = AppLocalizations.of(context).translate(_secondfrom.substring(_firstfrom.indexOf(' ') + 1, _firstfrom.length));
//                     _secondToTime = _secondTo.substring(0, _secondTo.indexOf(' '));
//                     _secondToAmPm = AppLocalizations.of(context).translate(_secondTo.substring(_secondTo.indexOf(' ') + 1, _secondTo.length));
//                     SearchResultData.secondTime = LocaleKeys.view_time_day_from.tr() +
//                         _secondfromTime +
//                         ' ' +
//                         _secondfromAmPm +
//                         ' ' +
//                         LocaleKeys.view_time_day_to.tr() +
//                         _secondToTime +
//                         ' ' +
//                         _secondToAmPm;
//                   }
//                   Navigator.pushNamed(context, '/patient location');
//                 },
//               ),
//             ),
//     );
//   }
// }
