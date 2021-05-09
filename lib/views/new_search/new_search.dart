import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/views/auth/loading_delete.dart';
import 'package:project_doctor/views/search_complain/patient_sidebar.dart';
import 'package:easy_localization/easy_localization.dart';

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
        style: TextStyle(fontSize: 15, fontFamily: lang == 'ar' ? 'noto_arabic' : 'Helvetica'),
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
        LocaleKeys.iraq_provinces_Erbil.tr(),
      ],
      "2": [
        "Al Anbar",
        LocaleKeys.iraq_provinces_Al_Anbar.tr(),
      ],
      "3": [
        "Basra",
        LocaleKeys.iraq_provinces_Basra.tr(),
      ],
      "4": [
        "Al Qadisiyyah",
        LocaleKeys.iraq_provinces_Al_Qadisiyyah.tr(),
      ],
      "5": [
        "Muthanna",
        LocaleKeys.iraq_provinces_Muthanna.tr(),
      ],
      "6": [
        "Najaf",
        LocaleKeys.iraq_provinces_Najaf.tr(),
      ],
      "7": [
        "Babil",
        LocaleKeys.iraq_provinces_Babil.tr(),
      ],
      "8": [
        'Baghdad',
        LocaleKeys.iraq_provinces_Baghdad.tr(),
      ],
      "9": [
        "Duhok",
        LocaleKeys.iraq_provinces_Duhok.tr(),
      ],
      "10": [
        "Diyala",
        LocaleKeys.iraq_provinces_Diyala.tr(),
      ],
      "11": [
        "Dhi Qar",
        LocaleKeys.iraq_provinces_Dhi_Qar.tr(),
      ],
      "12": [
        "Sulaymaniyah",
        LocaleKeys.iraq_provinces_Sulaymaniyah.tr(),
      ],
      "13": [
        "Saladin",
        LocaleKeys.iraq_provinces_Saladin.tr(),
      ],
      "14": [
        "Karbala",
        LocaleKeys.iraq_provinces_Karbala.tr(),
      ],
      "15": [
        "Kirkuk",
        LocaleKeys.iraq_provinces_Kirkuk.tr(),
      ],
      "16": [
        "Maysan",
        LocaleKeys.iraq_provinces_Maysan.tr(),
      ],
      "17": [
        "Nineveh",
        LocaleKeys.iraq_provinces_Nineveh.tr(),
      ],
      "18": [
        "Wasit",
        LocaleKeys.iraq_provinces_Wasit.tr(),
      ],
    };
    final Map specialities = {
      "1": [LocaleKeys.medical_specialty_Internist.tr(), 'Internist'],
      "2": [LocaleKeys.medical_specialty_Pediatrician.tr(), 'Pediatrician'],
      "3": [LocaleKeys.medical_specialty_Cardiologist.tr(), 'Cardiologist'],
      "4": [LocaleKeys.medical_specialty_Pulmonologist.tr(), 'Pulmonologist'],
      "5": [LocaleKeys.medical_specialty_Endocrinologist.tr(), 'Endocrinologist'],
      "6": [LocaleKeys.medical_specialty_Enterologist.tr(), 'Enterologist'],
      "7": [LocaleKeys.medical_specialty_Neurologist.tr(), 'Neurologist'],
      "8": [LocaleKeys.medical_specialty_Neurosurgeon.tr(), 'Neurosurgeon'],
      "9": [LocaleKeys.medical_specialty_Heamatologist.tr(), 'Heamatologist'],
      "10": [LocaleKeys.medical_specialty_Nephrologist.tr(), 'Nephrologist'],
      "11": [LocaleKeys.medical_specialty_Rheumatologist.tr(), 'Rheumatologist'],
      "12": [LocaleKeys.medical_specialty_Emergency_physician.tr(), 'Emergency physician'],
      "13": [LocaleKeys.medical_specialty_Dermatologist.tr(), 'Dermatologist'],
      "14": [LocaleKeys.medical_specialty_Psychiatrist.tr(), 'Psychiatrist'],
      "15": [LocaleKeys.medical_specialty_Gynecologist.tr(), 'Gynecologist'],
      "16": [LocaleKeys.medical_specialty_General_Surgeon.tr(), 'General Surgeon'],
      "17": [LocaleKeys.medical_specialty_Pediatric_Surgeon.tr(), 'Pediatric Surgeon'],
      "18": [LocaleKeys.medical_specialty_ThoracoVascular_Surgeon.tr(), 'ThoracoVascular Surgeon'],
      "19": [LocaleKeys.medical_specialty_Orthopaedic_Surgeon.tr(), 'Orthopaedic Surgeon'],
      "20": [LocaleKeys.medical_specialty_Urosurgeon.tr(), 'Urosurgeon'],
      "21": [LocaleKeys.medical_specialty_Plastic_Surgeon.tr(), 'Plastic Surgeon'],
      "22": [LocaleKeys.medical_specialty_Ophthalmologist.tr(), 'Ophthalmologist'],
      "23": [LocaleKeys.medical_specialty_Laryngologist.tr(), 'Laryngologist'],
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
            LocaleKeys.view_new_search_new_search.tr(),
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
                        LocaleKeys.view_doctor_province.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: getDeviceType(context, 12, 15, 18, 20)),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: DropdownButtonFormField(
                          hint: Text(
                            LocaleKeys.view_new_search_governorate.tr(),
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
                        title: Text(
                          LocaleKeys.view_new_search_name_search.tr(),
                        ),
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
                        title: Text(
                          LocaleKeys.view_new_search_speciality_search.tr(),
                        ),
                        value: _specialitySelected,
                        onChanged: (val) => setState(() {
                          _specialitySelected = !_specialitySelected;
                          NewSearchData.specialitySelected = _specialitySelected;
                          if (_nameSelected) {
                            _nameSelected = !_nameSelected;
                            NewSearchData.name = '';
                          }
                        }),
                      ),
                      _nameSelected
                          ? TextFormField(
                              validator: (val) => val.isEmpty ? LocaleKeys.view_new_search_name_validator.tr() : null,
                              onChanged: (val) {
                                setState(() => NewSearchData.name = val);
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              decoration: CStyle.getInputDecoration(context).copyWith(
                                hintText: LocaleKeys.view_new_search_enter_name.tr(),
                                labelText: LocaleKeys.view_new_search_enter_name.tr(),
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
                              decoration: CStyle.getInputDecoration(context).copyWith(
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
                              decoration: CStyle.getInputDecoration(context),
                              hint: Text(
                                LocaleKeys.view_doctor_speciality.tr(),
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
                              validator: (value) => value == null ? LocaleKeys.view_new_search_speciality_validator.tr() : null,
                              onChanged: (val) => setState(() => NewSearchData.speciality = val),
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
                  width: isLoading ? getDeviceType(context, 20, 40, 50, 50) : getDeviceType(context, 200, 220, 400, 400),
                  child: LoadingButton(
                    isloading: isLoading,
                    backgroundcolor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    onpressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => isLoading = true);
                        await checkInternet();
                        if (NewSearchData.province == null) {
                          _error = LocaleKeys.view_new_search_select_province.tr();
                          _showSnackBar();
                        } else {
                          if (!_nameSelected && !_specialitySelected) {
                            _error = LocaleKeys.view_new_search_enter_name_speciality.tr();
                            _showSnackBar();
                          } else {
                            if (!_isInternet) {
                              _error = LocaleKeys.error_snack_connectivity.tr();
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
                        LocaleKeys.view_new_search_new_search.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            // fontSize: 16,
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
