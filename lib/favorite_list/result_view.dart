import 'package:flutter/material.dart';
import 'package:project_doctor/constants/device_size.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';

class SearchResultView extends StatefulWidget {
  @override
  _SearchResultViewState createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          getDeviceTypeI(context, 36, 56, 56, 56),
        ),
        child: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            AppLocalizations.of(context).translate('doctor info'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: getDeviceTypeI(context, 16, 25, 35, 45),
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: getDeviceTypeI(context, 260, 340, 100, 500),
          padding: EdgeInsets.symmetric(
              vertical: getDeviceTypeI(context, 20, 25, 30, 35),
              horizontal: getDeviceTypeI(context, 20, 2, 3, 3)),
          child: ListView(
            children: [
              Container(
                decoration: boxDecoration,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getDeviceTypeI(context, 20, 32, 45, 60),
                    vertical: getDeviceTypeI(context, 10, 16, 20, 24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          radius: getDeviceTypeI(context, 40, 50, 60, 75),
                          backgroundImage:
                              AssetImage('assets/images/doctor.png'),
                        ),
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 10, 20, 30, 40),
                      ),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            SearchResultData.name,
                            style: TextStyle(
                                fontSize:
                                    getDeviceTypeI(context, 15, 18, 21, 24),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'noto_arabic'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 5, 5, 10, 15),
                      ),
                      Center(
                        child: Text(
                          // _doctorAddress,
                          AppLocalizations.of(context)
                              .translate(SearchResultData.province),
                          //style: _textStyle.copyWith(fontSize: footer),
                          style: TextStyle(
                              fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'noto_arabic'),
                        ),
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 5, 5, 10, 15),
                      ),
                      Divider(
                        color: Colors.grey[600],
                        thickness: 3,
                        indent: 25,
                        endIndent: 25,
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 5, 5, 10, 15),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('speciality'),
                        style: TextStyle(
                          //fontSize: footer,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 2, 2, 10, 10),
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate(SearchResultData.speciality),
                        style: TextStyle(
                          fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
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
                          fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 2, 2, 10, 10),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          //_makePhoneCall('tel:$_phone');
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
                                fontSize:
                                    getDeviceTypeI(context, 12, 15, 18, 21),
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
                        AppLocalizations.of(context)
                            .translate('clinic_address'),
                        style: TextStyle(
                          //fontSize: footer,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 2, 2, 10, 10),
                      ),
                      Text(
                        SearchResultData.address,
                        style: TextStyle(
                          fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
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
                          fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
                          fontFamily: 'noto_arabic',
                        ),
                      ),
                      SizedBox(
                        height: getDeviceTypeI(context, 2, 2, 10, 10),
                      ),
                      Text(
                        SearchResultData.workDays01.toString(),
                        //_finalMainDays + '\n' + _mainTime,
                        style: TextStyle(
                          fontSize: getDeviceTypeI(context, 12, 15, 18, 21),
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
                                    AppLocalizations.of(context)
                                        .translate('another_clinic_work'),
                                    style: TextStyle(
                                      // fontSize: footer,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                      fontSize: getDeviceTypeI(
                                          context, 12, 15, 18, 21),
                                      fontFamily: 'noto_arabic',
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        getDeviceTypeI(context, 2, 2, 10, 10),
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
                                        fontSize: getDeviceTypeI(
                                            context, 12, 15, 18, 21),
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
                      /*  Text(
                          AppLocalizations.of(context).translate("distances"),
                          style: TextStyle(
                             // fontSize: footer,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                         // realnearby +
                              AppLocalizations.of(context)
                                  .translate("km"), //' Km away',
                        //  style: _textStyle,
                        ),*/
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getDeviceTypeI(context, 20, 25, 30, 35),
              ),
              Container(
                // height: buttonHeight,
                // width: buttonWidth,
                child: RaisedButton.icon(
                  color: Colors.deepOrange,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  onPressed: () {},
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
