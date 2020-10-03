import 'package:flutter/material.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/constants/multi_selection.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/services/disease1.dart';
import 'package:project_doctor/services/disease2.dart';
import 'package:project_doctor/services/disease3.dart';
import 'package:project_doctor/services/disease4.dart';
import 'package:project_doctor/services/disease5.dart';
import 'package:project_doctor/services/disease6.dart';
import 'package:project_doctor/services/disease7.dart';

class PatientRisks extends StatefulWidget {
  String chiehcomplaint;
  String sym2;
  String sym3;
  String sym4;
  String sym5;
  String sym6;
  String sym7;
  PatientRisks(
      {this.chiehcomplaint,
      this.sym2,
      this.sym3,
      this.sym4,
      this.sym5,
      this.sym6,
      this.sym7});
  @override
  _PatientRisksState createState() => _PatientRisksState(
      cc: chiehcomplaint,
      s2: sym2,
      s3: sym3,
      s4: sym4,
      s5: sym5,
      s6: sym6,
      s7: sym7);
}

class _PatientRisksState extends State<PatientRisks> {
  String cc;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String s7;
  _PatientRisksState(
      {this.cc, this.s2, this.s3, this.s4, this.s5, this.s6, this.s7});
  TextStyle _textStylePatient = TextStyle(
    fontSize: 18,
    color: Colors.black,
  );

  String chronic1 = '';
  String chronic2 = '';
  String chronic3 = '';
  String chronic4 = '';
  String chronic5 = '';
  String chronic6 = '';
  String chronic7 = '';
  String chronic8 = '';
  String chronic9 = '';
  String chronic10 = '';
  String chronic11 = '';
  String chronic12 = '';
  String chronic13 = '';
  String chronic14 = '';
  String chronic15 = '';
  void _showChronicDiseaseMultiSelect(BuildContext context) async {
    chronic1 = '';
    chronic2 = '';
    chronic3 = '';
    chronic4 = '';
    chronic5 = '';
    chronic6 = '';
    chronic7 = '';
    chronic8 = '';
    chronic9 = '';
    chronic10 = '';
    chronic11 = '';
    chronic12 = '';
    chronic13 = '';
    chronic14 = '';
    chronic15 = '';
    final cdItems = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(
          1, AppLocalizations.of(context).translate('cd_HTN')),
      MultiSelectDialogItem(2, AppLocalizations.of(context).translate('cd_DM')),
      MultiSelectDialogItem(
          3, AppLocalizations.of(context).translate('cd_heart')),
      MultiSelectDialogItem(
          4, AppLocalizations.of(context).translate('cd_heartFailure')),
      MultiSelectDialogItem(
          5, AppLocalizations.of(context).translate('cd_ctd')),
      MultiSelectDialogItem(
          6, AppLocalizations.of(context).translate('cd_ckd')),
      MultiSelectDialogItem(
          7, AppLocalizations.of(context).translate('cd_liver')),
      MultiSelectDialogItem(
          8, AppLocalizations.of(context).translate('cd_intestine')),
      MultiSelectDialogItem(
          9, AppLocalizations.of(context).translate('cd_epilepsy')),
      MultiSelectDialogItem(
          10, AppLocalizations.of(context).translate('cd_cva')),
      MultiSelectDialogItem(
          11, AppLocalizations.of(context).translate('cd_thyroid')),
      MultiSelectDialogItem(
          12, AppLocalizations.of(context).translate('cd_lung')),
      MultiSelectDialogItem(
          13, AppLocalizations.of(context).translate('cd_copd')),
      MultiSelectDialogItem(
          14, AppLocalizations.of(context).translate('cd_ashma')),
      MultiSelectDialogItem(
          15, AppLocalizations.of(context).translate('cd_tumor')),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: cdItems,
        );
      },
    );
    var mappy = {1: 'headache', 2: 'abdominal pain'};
    for (var x in selectedValues) {
      if (x == 1) {
        chronic1 = 'HTN';
      }
      if (x == 2) {
        chronic2 = 'DM';
      }
      if (x == 3) {
        chronic3 = 'chronic heart disease';
      }
      if (x == 4) {
        chronic4 = 'heart failure';
      }
      if (x == 5) {
        chronic5 = 'connective tissue disease';
      }
      if (x == 6) {
        chronic6 = 'CKD';
      }
      if (x == 7) {
        chronic7 = 'liver disease';
      }
      if (x == 8) {
        chronic8 = 'chronic intestinal disease';
      }
      if (x == 9) {
        chronic9 = 'epilepsy';
      }
      if (x == 10) {
        chronic10 = 'CVA';
      }
      if (x == 11) {
        chronic11 = 'previous goitre';
      }
      if (x == 12) {
        chronic12 = 'chronic lung disease';
      }
      if (x == 13) {
        chronic13 = 'copd';
      }
      if (x == 14) {
        chronic14 = 'asthma';
      }
      if (x == 15) {
        chronic15 = 'malignancy';
      }
    }
    //chronics must be cleared after the pt proceed
    print(chronic1);
    print(chronic2);
    print(chronic3);
  }

  //--------checkboxes--------------//
  bool pregnancy = false;
  bool obesity = false;
  bool smoking = false;
  bool alcoholism = false;
  bool physicalinactive = false;
  bool familyhistory = false;
  String pregnancies = '';
  String obesities = '';
  String smoke = '';
  String alcohol = '';
  String inactive = '';
  String familyhx = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Fill The Data',
          style: TextStyle(fontSize: 25.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                decoration: boxDecorationPatient,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                AppLocalizations.of(context)
                                    .translate('patient_chronic_diseases'),
                                style: _textStylePatient),
                          ),
                          FlatButton(
                            onPressed: () =>
                                _showChronicDiseaseMultiSelect(context),
                            color: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('patient_dialogue_list_button'),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: boxDecorationPatient,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Obesity',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Checkbox(
                            value: obesity,
                            onChanged: (val) {
                              setState(() {
                                obesity = val;
                                if (obesity) {
                                  obesities = 'obesity';
                                } else {
                                  obesities = null;
                                }
                                print(obesities);
                              });
                            }),
                        Text(
                          'Physical inactivity',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Checkbox(
                          value: physicalinactive,
                          onChanged: (val) {
                            setState(() {
                              physicalinactive = val;
                              if (physicalinactive) {
                                inactive = 'physical inactivity';
                              } else {
                                inactive = '';
                              }
                              print(inactive);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Pregnancy',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 11.0,
                        ),
                        Checkbox(
                            value: pregnancy,
                            onChanged: (val) {
                              setState(() {
                                pregnancy = val;
                                if (pregnancy) {
                                  pregnancies = 'pregnancy';
                                } else {
                                  pregnancies = '';
                                }
                                print(pregnancies);
                              });
                            }),
                        SizedBox(
                          width: 21.0,
                        ),
                        Text(
                          'Alcoholism',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 11.0,
                        ),
                        Checkbox(
                          value: alcoholism,
                          onChanged: (val) {
                            setState(() {
                              alcoholism = val;
                              if (alcoholism) {
                                alcohol = 'alcoholism';
                              } else {
                                alcohol = '';
                              }
                              print(alcohol);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Smoking',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 11.0,
                        ),
                        Checkbox(
                            value: smoking,
                            onChanged: (val) {
                              setState(() {
                                smoking = val;
                                if (smoking) {
                                  smoke = 'smoking';
                                } else {
                                  smoke = '';
                                }
                                print(smoke);
                              });
                            }),
                        SizedBox(
                          width: 21.0,
                        ),
                        Text(
                          'Family history',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 11.0,
                        ),
                        Checkbox(
                          value: familyhistory,
                          onChanged: (val) {
                            setState(() {
                              familyhistory = val;
                              if (familyhistory) {
                                familyhx = 'family history';
                              } else {
                                familyhx = '';
                              }
                              print(familyhx);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(8),
                decoration: boxDecorationPatient,
                child: ListView(),
              ),
              SizedBox(
                height: 150,
              ),
              RaisedButton(
                child: Text('Show Result'),
                onPressed: () {

                  maindisease1(
                      cc,
                      s2,
                      s3,
                      s4,
                      s5,
                      s6,
                      s7,
                      chronic1,
                      chronic2,
                      chronic3,
                      chronic4,
                      chronic5,
                      chronic6,
                      chronic7,
                      chronic8,
                      chronic9,
                      chronic10,
                      chronic11,
                      chronic12,
                      chronic13,
                      chronic14,
                      chronic15,
                      pregnancies,
                      obesities,
                      inactive,
                      familyhx,
                      alcohol,
                      smoke);
                  maindisease3(
                      cc,
                      s2,
                      s3,
                      s4,
                      s5,
                      s6,
                      s7,
                      chronic1,
                      chronic2,
                      chronic3,
                      chronic4,
                      chronic5,
                      chronic6,
                      chronic7,
                      chronic8,
                      chronic9,
                      chronic10,
                      chronic11,
                      chronic12,
                      chronic13,
                      chronic14,
                      chronic15,
                      pregnancies,
                      obesities,
                      inactive,
                      familyhx,
                      alcohol,
                      smoke);
                  maindisease4(
                      cc,
                      s2,
                      s3,
                      s4,
                      s5,
                      s6,
                      s7,
                      chronic1,
                      chronic2,
                      chronic3,
                      chronic4,
                      chronic5,
                      chronic6,
                      chronic7,
                      chronic8,
                      chronic9,
                      chronic10,
                      chronic11,
                      chronic12,
                      chronic13,
                      chronic14,
                      chronic15,
                      pregnancies,
                      obesities,
                      inactive,
                      familyhx,
                      alcohol,
                      smoke);
                  maindisease5(
                      cc,
                      s2,
                      s3,
                      s4,
                      s5,
                      s6,
                      s7,
                      chronic1,
                      chronic2,
                      chronic3,
                      chronic4,
                      chronic5,
                      chronic6,
                      chronic7,
                      chronic8,
                      chronic9,
                      chronic10,
                      chronic11,
                      chronic12,
                      chronic13,
                      chronic14,
                      chronic15,
                      pregnancies,
                      obesities,
                      inactive,
                      familyhx,
                      alcohol,
                      smoke);
                  maindisease6(
                      cc,
                      s2,
                      s3,
                      s4,
                      s5,
                      s6,
                      s7,
                      chronic1,
                      chronic2,
                      chronic3,
                      chronic4,
                      chronic5,
                      chronic6,
                      chronic7,
                      chronic8,
                      chronic9,
                      chronic10,
                      chronic11,
                      chronic12,
                      chronic13,
                      chronic14,
                      chronic15,
                      pregnancies,
                      obesities,
                      inactive,
                      familyhx,
                      alcohol,
                      smoke);
                  maindisease7(
                      cc,
                      s2,
                      s3,
                      s4,
                      s5,
                      s6,
                      s7,
                      chronic1,
                      chronic2,
                      chronic3,
                      chronic4,
                      chronic5,
                      chronic6,
                      chronic7,
                      chronic8,
                      chronic9,
                      chronic10,
                      chronic11,
                      chronic12,
                      chronic13,
                      chronic14,
                      chronic15,
                      pregnancies,
                      obesities,
                      inactive,
                      familyhx,
                      alcohol,
                      smoke);
                  maindisease2(
                      cc,
                      s2,
                      s3,
                      s4,
                      s5,
                      s6,
                      s7,
                      chronic1,
                      chronic2,
                      chronic3,
                      chronic4,
                      chronic5,
                      chronic6,
                      chronic7,
                      chronic8,
                      chronic9,
                      chronic10,
                      chronic11,
                      chronic12,
                      chronic13,
                      chronic14,
                      chronic15,
                      pregnancies,
                      obesities,
                      inactive,
                      familyhx,
                      alcohol,
                      smoke);

                  Navigator.pushNamed(context, '/result');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
