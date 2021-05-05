import 'package:flutter/material.dart';
import 'package:project_doctor/services/theme.dart';
import 'package:project_doctor/matching_algorithm/disease1.dart';
import 'package:project_doctor/matching_algorithm/disease2.dart';
import 'package:project_doctor/matching_algorithm/disease3.dart';
import 'package:project_doctor/matching_algorithm/disease4.dart';
import 'package:project_doctor/matching_algorithm/disease5.dart';
import 'package:project_doctor/matching_algorithm/disease6.dart';
import 'package:project_doctor/matching_algorithm/disease7.dart';
import 'package:project_doctor/services/app_localizations.dart';


class PatientRiskFactors extends StatefulWidget {
  final String chiefcomplaint;
  final String sym2;
  final String sym3;
  final String sym4;
  final String sym5;
  final String sym6;
  final String sym7;
  final String gender;
  PatientRiskFactors({this.chiefcomplaint, this.sym2, this.sym3, this.sym4, this.sym5, this.sym6, this.sym7, this.gender});
  @override
  _PatientRiskFactorsState createState() =>
      _PatientRiskFactorsState(cc: chiefcomplaint, s2: sym2, s3: sym3, s4: sym4, s5: sym5, s6: sym6, s7: sym7, gender: gender);
}

class _PatientRiskFactorsState extends State<PatientRiskFactors> {
  String cc;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String s7;
  String gender;
  _PatientRiskFactorsState({this.cc, this.s2, this.s3, this.s4, this.s5, this.s6, this.s7, this.gender});

  //-----------------checkboxes------------------//

  bool htnSelected = false;
  bool dmSelected = false;
  bool chdSelected = false;
  bool hfSelected = false;
  bool ctdSelected = false;
  bool ckdSelected = false;
  bool ldSelected = false;
  bool cidSelected = false;
  bool epilepsySelected = false;
  bool cvaSelected = false;
  bool goitreSelected = false;
  bool cldSelected = false;
  bool copdSelected = false;
  bool ashmaSelected = false;
  bool malignancySelected = false;

  String htn = '';
  String dm = '';
  String chd = '';
  String hf = '';
  String ctd = '';
  String ckd = '';
  String ld = '';
  String cid = '';
  String epilepsy = '';
  String cva = '';
  String goitre = '';
  String cld = '';
  String copd = '';
  String ashma = '';
  String malignancy = '';
  bool pregnancySelected = false;
  bool obesitySelected = false;
  bool smokingSelected = false;
  bool alcoholismSelected = false;
  bool physicalinactiveSelected = false;
  bool familyhistorySelected = false;
  String pregnancy = '';
  String obesity = '';
  String smoking = '';
  String alcohol = '';
  String inactivity = '';
  String familyHistory = '';

  @override
  Widget build(BuildContext context) {
   
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.deepOrange,
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                AppLocalizations.of(context).translate('choose_one_more'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Container(
            height: 50,
            width: 150,
            child: FloatingActionButton.extended(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              elevation: 0.0,
              backgroundColor: Colors.deepOrange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
              onPressed: () async {
                maindisease1(cc, s2, s3, s4, s5, s6, s7, htn, dm, chd, hf, ctd, ckd, ld, cid, epilepsy, cva, goitre, cld, copd, ashma, malignancy,
                    pregnancy, obesity, inactivity, familyHistory, alcohol, smoking, gender);
                maindisease6(cc, s2, s3, s4, s5, s6, s7, htn, dm, chd, hf, ctd, ckd, ld, cid, epilepsy, cva, goitre, cld, copd, ashma, malignancy,
                    pregnancy, obesity, inactivity, familyHistory, alcohol, smoking, gender);
                maindisease3(cc, s2, s3, s4, s5, s6, s7, htn, dm, chd, hf, ctd, ckd, ld, cid, epilepsy, cva, goitre, cld, copd, ashma, malignancy,
                    pregnancy, obesity, inactivity, familyHistory, alcohol, smoking, gender);
                maindisease4(cc, s2, s3, s4, s5, s6, s7, htn, dm, chd, hf, ctd, ckd, ld, cid, epilepsy, cva, goitre, cld, copd, ashma, malignancy,
                    pregnancy, obesity, inactivity, familyHistory, alcohol, smoking, gender);
                maindisease5(cc, s2, s3, s4, s5, s6, s7, htn, dm, chd, hf, ctd, ckd, ld, cid, epilepsy, cva, goitre, cld, copd, ashma, malignancy,
                    pregnancy, obesity, inactivity, familyHistory, alcohol, smoking, gender);
                maindisease7(cc, s2, s3, s4, s5, s6, s7, htn, dm, chd, hf, ctd, ckd, ld, cid, epilepsy, cva, goitre, cld, copd, ashma, malignancy,
                    pregnancy, obesity, inactivity, familyHistory, alcohol, smoking, gender);
                maindisease2(cc, s2, s3, s4, s5, s6, s7, htn, dm, chd, hf, ctd, ckd, ld, cid, epilepsy, cva, goitre, cld, copd, ashma, malignancy,
                    pregnancy, obesity, inactivity, familyHistory, alcohol, smoking, gender);
                Navigator.pushNamed(context, '/patient_speciality_result');
              },
              label: Text(AppLocalizations.of(context).translate('next'),
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          decoration: boxDecoration,
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    AppLocalizations.of(context).translate('chronic_disease'),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: 30,
                                endIndent: 30,
                              ),
                              CheckboxListTile(
                                  title: Text(
                                    AppLocalizations.of(context).translate('cd_HTN'),
                                  ),
                                  value: htnSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      htnSelected = val;
                                      if (htnSelected) {
                                        htn = 'HTN';
                                      } else {
                                        htn = '';
                                      }
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_DM'), ),
                                  value: dmSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      dmSelected = val;
                                      if (dmSelected) {
                                        dm = 'DM';
                                      } else {
                                        dm = '';
                                      }
                                      print(dm);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_heart'), ),
                                  value: chdSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      chdSelected = val;
                                      if (chdSelected) {
                                        chd = 'chronic heart disease';
                                      } else {
                                        chd = '';
                                      }
                                      print(chd);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_heartFailure'), ),
                                  value: hfSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      hfSelected = val;
                                      if (hfSelected) {
                                        hf = 'heart failure';
                                      } else {
                                        hf = '';
                                      }
                                      print(hf);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_ctd'), ),
                                  value: ctdSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      ctdSelected = val;
                                      if (ctdSelected) {
                                        ctd = 'connective tissue disease';
                                      } else {
                                        ctd = '';
                                      }
                                      print(ctd);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_ckd'), ),
                                  value: ckdSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      ckdSelected = val;
                                      if (ckdSelected) {
                                        ckd = 'CKD';
                                      } else {
                                        ckd = '';
                                      }
                                      print(ckd);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_liver'), ),
                                  value: ldSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      ldSelected = val;
                                      if (ldSelected) {
                                        ld = 'liver disease';
                                      } else {
                                        ld = '';
                                      }
                                      print(ld);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_lung'), ),
                                  value: copdSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      copdSelected = val;
                                      if (copdSelected) {
                                        copd = 'copd';
                                      } else {
                                        copd = '';
                                      }
                                      print(copd);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_ashma'), ),
                                  value: ashmaSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      ashmaSelected = val;
                                      if (ashmaSelected) {
                                        ashma = 'asthma';
                                      } else {
                                        ashma = '';
                                      }
                                      print(ashma);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_thyroid'), ),
                                  value: goitreSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      goitreSelected = val;
                                      if (goitreSelected) {
                                        goitre = 'previous goitre';
                                      } else {
                                        goitre = '';
                                      }
                                      print(goitre);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_epilepsy'), ),
                                  value: epilepsySelected,
                                  onChanged: (val) {
                                    setState(() {
                                      epilepsySelected = val;
                                      if (epilepsySelected) {
                                        epilepsy = 'epilepsy';
                                      } else {
                                        epilepsy = '';
                                      }
                                      print(epilepsy);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_intestine'), ),
                                  value: cidSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      cidSelected = val;
                                      if (cidSelected) {
                                        cid = 'chronic intestinal disease';
                                      } else {
                                        cid = '';
                                      }
                                      print(cid);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_cva'), ),
                                  value: cvaSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      cvaSelected = val;
                                      if (cvaSelected) {
                                        cva = 'CVA';
                                      } else {
                                        cva = '';
                                      }
                                      print(cva);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('cd_tumor'), ),
                                  value: malignancySelected,
                                  onChanged: (val) {
                                    setState(() {
                                      malignancySelected = val;
                                      if (malignancySelected) {
                                        malignancy = 'malignancy';
                                      } else {
                                        malignancy = '';
                                      }
                                      print(malignancy);
                                    });
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration: boxDecoration,
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    AppLocalizations.of(context).translate('life_style'),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                indent: 30,
                                endIndent: 30,
                              ),
                              CheckboxListTile(
                                  title: Text(
                                    AppLocalizations.of(context).translate('obesity'),
                                  ),
                                  value: obesitySelected,
                                  onChanged: (val) {
                                    setState(() {
                                      obesitySelected = val;
                                      if (obesitySelected) {
                                        obesity = 'obesity';
                                      } else {
                                        obesity = null;
                                      }
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('physical_inactive'), ),
                                  value: physicalinactiveSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      physicalinactiveSelected = val;
                                      if (physicalinactiveSelected) {
                                        inactivity = 'physical inactivity';
                                      } else {
                                        inactivity = '';
                                      }
                                      print(inactivity);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('alcohol'),),
                                  value: alcoholismSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      alcoholismSelected = val;
                                      if (alcoholismSelected) {
                                        alcohol = 'alcoholism';
                                      } else {
                                        alcohol = '';
                                      }
                                      print(alcohol);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('smoking'),),
                                  value: smokingSelected,
                                  onChanged: (val) {
                                    setState(() {
                                      smokingSelected = val;
                                      if (smokingSelected) {
                                        smoking = 'smoking';
                                      } else {
                                        smoking = '';
                                      }
                                      print(smoking);
                                    });
                                  }),
                              CheckboxListTile(
                                  title: Text(AppLocalizations.of(context).translate('family'),  ),
                                  value: familyhistorySelected,
                                  onChanged: (val) {
                                    setState(() {
                                      familyhistorySelected = val;
                                      if (familyhistorySelected) {
                                        familyHistory = 'family history';
                                      } else {
                                        familyHistory = '';
                                      }
                                      print(familyHistory);
                                    });
                                  }),
                              gender == "Female"
                                  ? CheckboxListTile(
                                      title: Text(AppLocalizations.of(context).translate('pregnancy'),),
                                      value: pregnancySelected,
                                      onChanged: (val) {
                                        setState(() {
                                          pregnancySelected = val;
                                          if (pregnancySelected) {
                                            pregnancy = 'pregnancy';
                                          } else {
                                            pregnancy = '';
                                          }
                                          print(pregnancy);
                                        });
                                      })
                                  : Text(' '),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
   
  }
}
