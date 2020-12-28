import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:project_doctor/pages/doctor_pages/doctor05.5_update_clinic.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/doctor_pages/doctor07_update_password.dart';
import 'package:project_doctor/ui/responsive_builder.dart';
import 'package:project_doctor/ui/device_screen_type.dart';
import 'package:project_doctor/ui/sizing_information.dart';

class Updateinfo extends StatefulWidget {
  final String profileName;
  final String profileSpeciality;
  Updateinfo({this.profileName, this.profileSpeciality});
  @override
  _UpdateinfoState createState() => _UpdateinfoState(
      profileName: profileName, profileSpeciality: profileSpeciality);
}

class _UpdateinfoState extends State<Updateinfo> {
  final String profileName;
  final String profileSpeciality;
  _UpdateinfoState({this.profileName, this.profileSpeciality});
  String name = '';
  String speciality = '';
  String phonenumber = '';
  String _province;
  String address = '';

  final _formkey = GlobalKey<FormState>();
  String _error = '';
  //-----------validate phonenumber------------
  int _number = 0;
  int finalNumber = 0;
  String error;
  validateNumber(String number) {
    try {
      _number = int.parse(number);
      return _number;
    } catch (e) {
      return null;
    }
  }

  //==============snackbar for empty latlng============
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final snackBar = new SnackBar(
      content: new Text(
        _error,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),

      //duration: new Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    );
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;

    final specialities = {
      "1": [AppLocalizations.of(context).translate('Internist'), 'Internist'],
      "2": [
        AppLocalizations.of(context).translate('Pediatrician'),
        'Pediatrician'
      ],
      "3": [
        AppLocalizations.of(context).translate('Cardiologist'),
        'Cardiologist'
      ],
      "4": [
        AppLocalizations.of(context).translate('Pulmonologist'),
        'Pulmonologist'
      ],
      "5": [
        AppLocalizations.of(context).translate('Endocrinologist'),
        'Endocrinologist'
      ],
      "6": [
        AppLocalizations.of(context).translate('Enterologist'),
        'Enterologist'
      ],
      "7": [
        AppLocalizations.of(context).translate('Neurologist'),
        'Neurologist'
      ],
      "8": [
        AppLocalizations.of(context).translate('Neurosurgeon'),
        'Neurosurgeon'
      ],
      "9": [
        AppLocalizations.of(context).translate('Heamatologist'),
        'Heamatologist'
      ],
      "10": [
        AppLocalizations.of(context).translate('Nephrologist'),
        'Nephrologist'
      ],
      "11": [
        AppLocalizations.of(context).translate('Rheumatologist'),
        'Rheumatologist'
      ],
      "12": [
        AppLocalizations.of(context).translate('Emergency physician'),
        'Emergency physician'
      ],
      "13": [
        AppLocalizations.of(context).translate('Dermatologist'),
        'Dermatologist'
      ],
      "14": [
        AppLocalizations.of(context).translate('Psychiatrist'),
        'Psychiatrist'
      ],
      "15": [
        AppLocalizations.of(context).translate('Gynecologist'),
        'Gynecologist'
      ],
      "16": [
        AppLocalizations.of(context).translate('General Surgeon'),
        'General Surgeon'
      ],
      "17": [
        AppLocalizations.of(context).translate('Pediatric Surgeon'),
        'Pediatric Surgeon'
      ],
      "18": [
        AppLocalizations.of(context).translate('ThoracoVascular Surgeon'),
        'ThoracoVascular Surgeon'
      ],
      "19": [
        AppLocalizations.of(context).translate('Orthopaedic Surgeon'),
        'Orthopaedic Surgeon'
      ],
      "20": [
        AppLocalizations.of(context).translate('Urosurgeon'),
        'Urosurgeon'
      ],
      "21": [
        AppLocalizations.of(context).translate('Plastic Surgeon'),
        'Plastic Surgeon'
      ],
      "22": [
        AppLocalizations.of(context).translate('Ophthalmologist'),
        'Ophthalmologist'
      ],
      "23": [
        AppLocalizations.of(context).translate('Laryngologist'),
        'Laryngologist'
      ],
    };
    final province = {
      /*"1": [
        'Baghdad',
        AppLocalizations.of(context).translate('Baghdad'),
      ],
      "2": [
        'Northern Region',
        AppLocalizations.of(context).translate("Northern Region"),
      ],
      "3": [
        'Southern Region',
        AppLocalizations.of(context).translate("Southern Region"),
      ],
      "4": [
        'Western Region',
        AppLocalizations.of(context).translate("Western Region"),
      ],
      "5": [
        'Middle Region',
        AppLocalizations.of(context).translate("Middle Region"),
      ],*/
      "1": [
        "Erbil",
        AppLocalizations.of(context).translate("Erbil"),
      ],
      "2": [
        "Al Anbar",
        AppLocalizations.of(context).translate("Al Anbar"),
      ],
      "3": [
        "Basra",
        AppLocalizations.of(context).translate("Basra"),
      ],
      "4": [
        "Al Qadisiyyah",
        AppLocalizations.of(context).translate("Al Qadisiyyah"),
      ],
      "5": [
        "Muthanna",
        AppLocalizations.of(context).translate("Muthanna"),
      ],
      "6": [
        "Najaf",
        AppLocalizations.of(context).translate("Najaf"),
      ],
      "7": [
        "Babil",
        AppLocalizations.of(context).translate("Babil"),
      ],
      "8": [
        'Baghdad',
        AppLocalizations.of(context).translate('Baghdad'),
      ],
      "9": ["Duhok", AppLocalizations.of(context).translate("Duhok")],
      "10": ["Diyala", AppLocalizations.of(context).translate("Diyala")],
      "11": ["Dhi Qar", AppLocalizations.of(context).translate("Dhi Qar")],
      "12": [
        "Sulaymaniyah",
        AppLocalizations.of(context).translate("Sulaymaniyah")
      ],
      "13": ["Saladin", AppLocalizations.of(context).translate("Saladin")],
      "14": ["Karbala", AppLocalizations.of(context).translate("Karbala")],
      "15": ["Kirkuk", AppLocalizations.of(context).translate("Kirkuk")],
      "16": ["Maysan", AppLocalizations.of(context).translate("Maysan")],
      "17": ["Nineveh", AppLocalizations.of(context).translate("Nineveh")],
      "18": ["Wasit", AppLocalizations.of(context).translate("Wasit")],
    };

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double appBarTitle;
      double appBarHeight;
      double containerWidth;
      double buttonHeight;
      double buttonWidth;
      double title;
      double footer;
      double topInset;
      double buttomInset;

      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile) {
        appBarTitle = 25;
        appBarHeight = 50;
        containerWidth = displayWidth(context) * 0.75;
        title = displayWidth(context) * 0.05;
        footer = displayWidth(context) * 0.035;
        buttonWidth = displayWidth(context) * 0.7;
        topInset = 50;
        buttomInset = 15;
      } else {
        appBarTitle = displayHeight(context) * 0.03;
        appBarHeight = 80;
        containerWidth = displayWidth(context) * 0.5;
        title = displayWidth(context) * 0.035;
        footer = displayWidth(context) * 0.025;
        buttonHeight = displayHeight(context) * 0.045;
        buttonWidth = displayWidth(context) * 0.4;
        topInset = 200;
        buttomInset = 80;
      }
      return Scaffold(
        key: _scaffoldkey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('update_info'),
                style: TextStyle(
                    fontSize: appBarTitle, fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Center(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.fromLTRB(0, topInset, 0, buttomInset),
            child: Form(
              key: _formkey,
              child: Container(
                height: double.maxFinite,
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        decoration: textInputdecoration.copyWith(
                            hintText:
                                AppLocalizations.of(context).translate('name'),
                            labelText:
                                AppLocalizations.of(context).translate('name')),
                        onChanged: (val) {
                          name = val;
                        },
                        validator: (val) => val.isEmpty
                            ? AppLocalizations.of(context)
                                .translate('name_validator')
                            : null,
                      ),
                    ),
                    Spacer(),
                    DropdownButtonFormField<String>(
                      decoration: textInputdecoration,
                      isDense: false,
                      hint: Text(
                        AppLocalizations.of(context).translate('speciality'),
                      ),
                      dropdownColor: Colors.grey[200],
                      elevation: 5,
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: specialities['1'][1],
                          child: Text(specialities['1'][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["2"][1],
                          child: Text(specialities["2"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["3"][1],
                          child: Text(specialities["3"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["4"][1],
                          child: Text(specialities["4"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["5"][1],
                          child: Text(specialities["5"][0]),
                        ), //5
                        DropdownMenuItem(
                          value: specialities["6"][1],
                          child: Text(specialities["6"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["7"][1],
                          child: Text(specialities["7"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["8"][1],
                          child: Text(specialities["8"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["9"][1],
                          child: Text(specialities["9"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["10"][1],
                          child: Text(specialities["10"][0]),
                        ), //10
                        DropdownMenuItem(
                          value: specialities["11"][1],
                          child: Text(specialities["11"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["12"][1],
                          child: Text(specialities["12"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["13"][1],
                          child: Text(specialities['13'][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["14"][1],
                          child: Text(specialities["14"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["15"][1],
                          child: Text(specialities["15"][0]),
                        ), //15
                        DropdownMenuItem(
                          value: specialities["16"][1],
                          child: Text(specialities["16"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["17"][1],
                          child: Text(specialities["17"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["18"][1],
                          child: Text(specialities["18"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["19"][1],
                          child: Text(specialities["19"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["20"][1],
                          child: Text(specialities["20"][0]),
                        ), //20
                        DropdownMenuItem(
                          value: specialities["21"][1],
                          child: Text(specialities["21"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["22"][1],
                          child: Text(specialities["22"][0]),
                        ),
                        DropdownMenuItem(
                          value: specialities["23"][1],
                          child: Text(specialities["23"][0]),
                        )
                      ],
                      validator: (value) => value == null
                          ? AppLocalizations.of(context)
                              .translate('speciality_validator')
                          : null,
                      onChanged: (val) => setState(() => speciality = val),
                    ),
                    Spacer(),
                    TextFormField(
                        onChanged: (val) => setState(() => phonenumber = val),
                        keyboardType: TextInputType.phone,
                        decoration: textInputdecoration.copyWith(
                          hintText: AppLocalizations.of(context)
                              .translate('phoneNumber'),
                          labelText: AppLocalizations.of(context)
                              .translate('phoneNumber'),
                        ),
                        validator: (val) => val.length < 11 && val.length > 11
                            ? AppLocalizations.of(context)
                                .translate('phoneNumber_validator')
                            : null),
                    Spacer(),
                    DropdownButtonFormField<String>(
                      isDense: false,
                      decoration: textInputdecoration,
                      hint: Text(
                        AppLocalizations.of(context).translate('province'),
                      ),
                      dropdownColor: Colors.grey[200],
                      elevation: 5,
                      icon: Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: province["1"][0],
                          child: Text(province["1"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["2"][0],
                          child: Text(province["2"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["3"][0],
                          child: Text(province["3"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["4"][0],
                          child: Text(province["4"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["5"][0],
                          child: Text(province["5"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["6"][0],
                          child: Text(province["6"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["7"][0],
                          child: Text(province["7"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["8"][0],
                          child: Text(province["8"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["9"][0],
                          child: Text(province["9"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["10"][0],
                          child: Text(province["10"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["11"][0],
                          child: Text(province["11"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["12"][0],
                          child: Text(province["12"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["13"][0],
                          child: Text(province["13"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["14"][0],
                          child: Text(province["14"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["15"][0],
                          child: Text(province["15"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["16"][0],
                          child: Text(province["16"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["17"][0],
                          child: Text(province["17"][1]),
                        ),
                        DropdownMenuItem(
                          value: province["18"][0],
                          child: Text(province["18"][1]),
                        ),
                      ],
                      validator: (value) =>
                          value == null ? 'Select your province' : null,
                      onChanged: (val) => setState(() => _province = val),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('finish_update'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: footer),
                        ),
                        Icon(
                          Icons.arrow_downward,
                          size: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: RaisedButton.icon(
                        color: Colors.deepOrange,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            finalNumber = await validateNumber(phonenumber);
                            if (finalNumber != null) {
                              if ((profileName == name || profileName == '') &&
                                  (profileSpeciality == speciality ||
                                      profileSpeciality == '')) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UpdateInfo2(
                                      name: name,
                                      speciality: speciality,
                                      phoneNumber: finalNumber.toString(),
                                      province: _province,
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _error = AppLocalizations.of(context)
                                      .translate('snack_update');
                                });
                                _showSnackBar();
                              }
                            } else {
                              _error = AppLocalizations.of(context)
                                  .translate('age_format');
                              _showSnackBar();
                            }
                          }
                        },
                        label: Text(
                          AppLocalizations.of(context).translate('next'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: title,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        print(speciality);
                        print(_province);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdatePassword()));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: '',
                          style: TextStyle(
                            fontSize: footer,
                            color: Colors.black,
                            fontFamily:
                                lang == 'ar' ? 'noto_arabic' : 'Helvetica',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate('change_password')),
                            TextSpan(
                                text: " " +
                                    AppLocalizations.of(context)
                                        .translate('change'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
