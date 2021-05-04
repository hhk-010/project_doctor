import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/services/theme.dart';
import 'package:project_doctor/favorite_list/favorite_list.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/read_write_path.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultView extends StatefulWidget {
  final Storage storage = Storage();
  @override
  _SearchResultViewState createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String favored01 = '';
  String favored02 = '';
  String favored03 = '';
  String favored04 = '';
  String favored05 = '';
  String favored06 = '';
  String favored07 = '';
  String favored08 = '';
  String favored09 = '';
  String favored10 = '';

  Future<File> _writeFavorite01(String value) {
    setState(() => favored01 = value);
    return widget.storage.writeFavorite01(favored01);
  }

  Future<File> _writeFavorite02(String value) {
    setState(() => favored02 = value);
    return widget.storage.writeFavorite02(favored02);
  }

  Future<File> _writeFavorite03(String value) {
    setState(() => favored03 = value);
    return widget.storage.writeFavorite03(favored03);
  }

  Future<File> _writeFavorite04(String value) {
    setState(() => favored04 = value);
    return widget.storage.writeFavorite04(favored04);
  }

  Future<File> _writeFavorite05(String value) {
    setState(() => favored05 = value);
    return widget.storage.writeFavorite05(favored05);
  }

  Future<File> _writeFavorite06(String value) {
    setState(() => favored06 = value);
    return widget.storage.writeFavorite06(favored06);
  }

  Future<File> _writeFavorite07(String value) {
    setState(() => favored07 = value);
    return widget.storage.writeFavorite07(favored07);
  }

  Future<File> _writeFavorite08(String value) {
    setState(() => favored08 = value);
    return widget.storage.writeFavorite08(favored08);
  }

  Future<File> _writeFavorite09(String value) {
    setState(() => favored09 = value);
    return widget.storage.writeFavorite09(favored09);
  }

  Future<File> _writeFavorite10(String value) {
    setState(() => favored10 = value);
    return widget.storage.writeFavorite10(favored10);
  }

  String phoneNumber = '';
  String _error = '';
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackBar = new SnackBar(
      content: Text(
        _error,
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    phoneNumber = SearchResultData.phoneNumber;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          getDeviceType(context, 36, 56, 56, 56),
        ),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            AppLocalizations.of(context).translate('doctor info'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: getDeviceType(context, 16, 25, 35, 45),
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await widget.storage.readFavorite01().then((value) => setState(() => Favorite.favorite01 = value));
                await widget.storage.readFavorite02().then((value) => setState(() => Favorite.favorite02 = value));
                await widget.storage.readFavorite03().then((value) => setState(() => Favorite.favorite03 = value));
                await widget.storage.readFavorite04().then((value) => setState(() => Favorite.favorite04 = value));
                await widget.storage.readFavorite05().then((value) => setState(() => Favorite.favorite05 = value));
                await widget.storage.readFavorite06().then((value) => setState(() => Favorite.favorite06 = value));
                await widget.storage.readFavorite07().then((value) => setState(() => Favorite.favorite07 = value));
                await widget.storage.readFavorite08().then((value) => setState(() => Favorite.favorite08 = value));
                await widget.storage.readFavorite09().then((value) => setState(() => Favorite.favorite09 = value));
                await widget.storage.readFavorite10().then((value) => setState(() => Favorite.favorite10 = value));
                setState(() => Favorite.favoriteIdlist = [
                      Favorite.favorite01,
                      Favorite.favorite02,
                      Favorite.favorite03,
                      Favorite.favorite04,
                      Favorite.favorite05,
                      Favorite.favorite06,
                      Favorite.favorite07,
                      Favorite.favorite08,
                      Favorite.favorite09,
                      Favorite.favorite10
                    ]);
                if (!FavoriteTile.favoriteListSelected) {
                  if (Favorite.favoriteIdlist.contains(SearchResultData.id.toString())) {
                    _error = AppLocalizations.of(context).translate('added previously');
                    _showSnackBar();
                  } else {
                    await _writeFavorite01(SearchResultData.id.toString());
                    await _writeFavorite02(Favorite.favorite01);
                    await _writeFavorite03(Favorite.favorite02);
                    await _writeFavorite04(Favorite.favorite03);
                    await _writeFavorite05(Favorite.favorite04);
                    await _writeFavorite06(Favorite.favorite05);
                    await _writeFavorite07(Favorite.favorite06);
                    await _writeFavorite08(Favorite.favorite07);
                    await _writeFavorite09(Favorite.favorite08);
                    await _writeFavorite10(Favorite.favorite09);
                    _error = AppLocalizations.of(context).translate('added successfully');
                    _showSnackBar();
                  }
                } else {
                  int count = 1;
                  for (String id in Favorite.favoriteIdlist) {
                    if (SearchResultData.id.toString() == id) {
                      if (count == 1) {
                        await _writeFavorite01('');
                      } else if (count == 2) {
                        await _writeFavorite02('');
                      } else if (count == 3) {
                        await _writeFavorite03('');
                      } else if (count == 4) {
                        await _writeFavorite04('');
                      } else if (count == 5) {
                        await _writeFavorite05('');
                      } else if (count == 6) {
                        await _writeFavorite06('');
                      } else if (count == 7) {
                        await _writeFavorite07('');
                      } else if (count == 8) {
                        await _writeFavorite08('');
                      } else if (count == 9) {
                        await _writeFavorite09('');
                      } else if (count == 10) {
                        await _writeFavorite10('');
                      }
                    }
                    count++;
                  }
                  _error = AppLocalizations.of(context).translate('removed successfully');
                  _showSnackBar();
                }
              },
              icon: Icon(
                FavoriteTile.favoriteListSelected ? Icons.star_border : Icons.star,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: getDeviceType(context, 260, 340, 100, 500),
          padding: EdgeInsets.symmetric(vertical: getDeviceType(context, 20, 25, 30, 35), horizontal: getDeviceType(context, 20, 2, 3, 3)),
          child: ListView(
            children: [
              Container(
                decoration: boxDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getDeviceType(context, 20, 32, 45, 60),
                    vertical: getDeviceType(context, 10, 16, 20, 24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          radius: getDeviceType(context, 40, 50, 60, 75),
                          backgroundImage: AssetImage('assets/images/doctor.png'),
                        ),
                      ),
                      SizedBox(
                        height: getDeviceType(context, 10, 20, 30, 40),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            SearchResultData.name,
                            style:
                                TextStyle(fontSize: getDeviceType(context, 15, 18, 21, 24), fontWeight: FontWeight.bold, fontFamily: 'noto_arabic'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getDeviceType(context, 5, 5, 10, 15),
                      ),
                      Center(
                        child: Text(
                          // _doctorAddress,
                          AppLocalizations.of(context).translate(SearchResultData.province),
                          //style: _textStyle.copyWith(fontSize: footer),
                          style: TextStyle(fontSize: getDeviceType(context, 12, 15, 18, 21), fontWeight: FontWeight.bold, fontFamily: 'noto_arabic'),
                        ),
                      ),
                      SizedBox(
                        height: getDeviceType(context, 5, 5, 10, 15),
                      ),
                      Divider(
                        color: Colors.grey[600],
                        thickness: 3,
                        indent: 25,
                        endIndent: 25,
                      ),
                      SizedBox(
                        height: getDeviceType(context, 5, 5, 10, 15),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('speciality'),
                        style: TextStyle(
                          //fontSize: footer,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceType(context, 2, 2, 10, 10),
                      ),
                      Text(
                        AppLocalizations.of(context).translate(SearchResultData.speciality),
                        style: TextStyle(
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('phoneNumber'),
                        style: TextStyle(
                          // fontSize: footer,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceType(context, 2, 2, 10, 10),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _makePhoneCall('tel:$phoneNumber');
                        }),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              SearchResultData.phoneNumber,
                              style: TextStyle(
                                fontSize: getDeviceType(context, 12, 15, 18, 21),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'noto_arabic',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('clinic_address'),
                        style: TextStyle(
                          //fontSize: footer,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceType(context, 2, 2, 10, 10),
                      ),
                      Text(
                        SearchResultData.address,
                        style: TextStyle(
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('clinic_work'),
                        style: TextStyle(
                          // fontSize: footer,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceType(context, 2, 2, 10, 10),
                      ),
                      Text(
                        SearchResultData.workDays01.toString(),
                        //_finalMainDays + '\n' + _mainTime,
                        style: TextStyle(
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SearchResultData.firstDay.isEmpty
                          ? Container()
                          : Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context).translate('another_clinic_work'),
                                    style: TextStyle(
                                      // fontSize: footer,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: getDeviceType(context, 12, 15, 18, 21),
                                      fontFamily: 'noto_arabic',
                                    ),
                                  ),
                                  SizedBox(
                                    height: getDeviceType(context, 2, 2, 10, 10),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      SearchResultData.firstDay +
                                          " " +
                                          SearchResultData.firstTime +
                                          '\n' +
                                          SearchResultData.secondDay +
                                          " " +
                                          SearchResultData.secondTime,
                                      style: TextStyle(
                                        fontSize: getDeviceType(context, 12, 15, 18, 21),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'noto_arabic',
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                ],
                              ),
                            ),
                      Text(
                        AppLocalizations.of(context).translate("distances"),
                        style: TextStyle(
                            // fontSize: footer,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        SearchResultData.distance.toString() + " " + AppLocalizations.of(context).translate("km"), //' Km away',
                        style: TextStyle(
                          fontSize: getDeviceType(context, 12, 15, 18, 21),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getDeviceType(context, 20, 25, 30, 35),
              ),
              Container(
                // height: buttonHeight,
                // width: buttonWidth,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  ),
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/doctor location map'),
                  label: Text(
                    AppLocalizations.of(context).translate("doctor_locat"),
                    style: TextStyle(
                        color: Colors.white,
                        // fontSize: subTitle,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
