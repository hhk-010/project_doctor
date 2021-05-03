import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/constants.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/pages/patient_pages/patient_sidebar.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';

class NewSearch extends StatefulWidget {
  @override
  _NewSearchState createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    var lang = Localizations.localeOf(context).languageCode;

    final _snackBar = new SnackBar(
      content: Text(
        _error,
        style: TextStyle(
            fontSize: 15,
            fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  bool _isInternet = true;
  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _isInternet = true; // internet
      }
    } on SocketException catch (_) {
      _isInternet = false; // no internet
    }
  }

  String _error = '';
  bool _nameSelected = false;
  bool _specialitySelected = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    NewSearchData.province = null;
    NewSearchData.name = '';
    NewSearchData.speciality = '';
    isLoading = false;
    SelectedPage.complaintSelected = false;
    SelectedPage.favoriteSelected = false;
    SelectedPage.lastSearchSelected = false;
    SelectedPage.newSearchSelected = true;
  }

  @override
  Widget build(BuildContext context) {
    final province = {
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
    final Map specialities = {
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
            AppLocalizations.of(context).translate('new search'),
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
        ),
      ),
      drawer: Container(
        width: getDeviceType(context, 180, 290, 520, 600),
        child: PatientSidebar(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: getDeviceType(context, 10, 20, 30, 40),
          horizontal: getDeviceType(context, 10, 20, 30, 40),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getDeviceType(context, 20, 30, 40, 50),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getDeviceType(context, 10, 20, 30, 40),
                    horizontal: getDeviceType(context, 10, 20, 30, 40),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        getDeviceType(context, 10, 20, 30, 40),
                      ),
                    ),
                    border: Border.all(
                      color: Colors.deepOrange,
                      width: getDeviceType(context, 2, 2, 3, 3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('province'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getDeviceType(context, 12, 15, 18, 20)),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: DropdownButtonFormField(
                          hint: Text(
                            AppLocalizations.of(context)
                                .translate('governorate'),
                          ),
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
                          onChanged: (value) {
                            setState(() {
                              NewSearchData.province = value;
                              DatabaseService.province = value;
                            });
                          },
                          value: NewSearchData.province,
                          dropdownColor: Colors.grey[300],
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getDeviceType(context, 20, 30, 40, 50),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getDeviceType(context, 10, 20, 30, 40),
                    horizontal: getDeviceType(context, 10, 20, 30, 40),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        getDeviceType(context, 10, 20, 30, 40),
                      ),
                    ),
                    border: Border.all(
                      color: Colors.deepOrange,
                      width: getDeviceType(context, 2, 2, 3, 3),
                    ),
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(AppLocalizations.of(context)
                            .translate('name search')),
                        value: _nameSelected,
                        onChanged: (val) => setState(() {
                          _nameSelected = !_nameSelected;
                          NewSearchData.nameSelected = _nameSelected;
                          if (_specialitySelected) {
                            _specialitySelected = !_specialitySelected;
                            NewSearchData.speciality = '';
                          }
                        }),
                      ),
                      CheckboxListTile(
                        title: Text(AppLocalizations.of(context)
                            .translate('speciality search')),
                        value: _specialitySelected,
                        onChanged: (val) => setState(() {
                          _specialitySelected = !_specialitySelected;
                          NewSearchData.specialitySelected =
                              _specialitySelected;
                          if (_nameSelected) {
                            _nameSelected = !_nameSelected;
                            NewSearchData.name = '';
                          }
                        }),
                      ),
                      _nameSelected
                          ? TextFormField(
                              validator: (val) => val.isEmpty
                                  ? AppLocalizations.of(context)
                                      .translate('name validator')
                                  : null,
                              onChanged: (val) {
                                setState(() => NewSearchData.name = val);
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputdecoration.copyWith(
                                hintText: AppLocalizations.of(context)
                                    .translate('enter name'),
                                labelText: AppLocalizations.of(context)
                                    .translate('enter name'),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            )
                          : Container(),
                      /* SizedBox(
                        height: getDeviceTypeI(context, 5, 10, 15, 20),
                      ),*/
                      /*_specialitySelected
                          ? TextFormField(
                              validator: (val) => val.isEmpty
                                  ? AppLocalizations.of(context)
                                      .translate('speciality validator')
                                  : null,
                              onChanged: (val) {
                                setState(() => NewSearchData.speciality = val);
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputdecoration.copyWith(
                                hintText: AppLocalizations.of(context)
                                    .translate('enter speciality'),
                                labelText: AppLocalizations.of(context)
                                    .translate('enter speciality'),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            )
                          : Container(),*/
                      _specialitySelected
                          ? DropdownButtonFormField<String>(
                              //value: NewSearchData.speciality,
                              isDense: false,
                              decoration: textInputdecoration,
                              hint: Text(
                                AppLocalizations.of(context)
                                    .translate('speciality'),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
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
                              onChanged: (val) => setState(
                                  () => NewSearchData.speciality = val),
                            )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  height: getDeviceType(context, 40, 160, 400, 400),
                ),
                Container(
                  height: getDeviceType(context, 20, 40, 70, 50),
                  width: isLoading
                      ? getDeviceType(context, 20, 40, 50, 50)
                      : getDeviceType(context, 200, 220, 400, 400),
                  child: LoadingButton(
                    isloading: isLoading,
                    backgroundcolor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    onpressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => isLoading = true);
                        await checkInternet();
                        if (NewSearchData.province == null) {
                          _error = AppLocalizations.of(context)
                              .translate('select province');
                          _showSnackBar();
                        } else {
                          if (!_nameSelected && !_specialitySelected) {
                            _error = AppLocalizations.of(context)
                                .translate('enter a name or speciality');
                            _showSnackBar();
                          } else {
                            if (!_isInternet) {
                              _error = AppLocalizations.of(context)
                                  .translate('snack_connectivity');
                              _showSnackBar();
                            } else {
                              Navigator.pushNamed(context, '/search listview');
                            }
                          }
                        }
                        setState(() => isLoading = false);
                      }
                    },
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        AppLocalizations.of(context).translate('search'),
                        style: TextStyle(
                            color: Colors.white,
                            // fontSize: title,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
