import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';
import 'package:project_doctor/matching_algorithm/disease1.dart';
import 'package:project_doctor/matching_algorithm/disease2.dart';
import 'package:project_doctor/matching_algorithm/disease3.dart';
import 'package:project_doctor/matching_algorithm/disease4.dart';
import 'package:project_doctor/matching_algorithm/disease5.dart';
import 'package:project_doctor/matching_algorithm/disease6.dart';
import 'package:project_doctor/matching_algorithm/disease7.dart';

class PatientRiskFactors extends StatefulWidget {
  final String chiefcomplaint;
  final String sym2;
  final String sym3;
  final String sym4;
  final String sym5;
  final String sym6;
  final String sym7;
  final String gender;
  PatientRiskFactors(
      {this.chiefcomplaint,
      this.sym2,
      this.sym3,
      this.sym4,
      this.sym5,
      this.sym6,
      this.sym7,
      this.gender});
  @override
  _PatientRiskFactorsState createState() => _PatientRiskFactorsState(
      cc: chiefcomplaint,
      s2: sym2,
      s3: sym3,
      s4: sym4,
      s5: sym5,
      s6: sym6,
      s7: sym7,
      gender: gender);
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
  _PatientRiskFactorsState(
      {this.cc,
      this.s2,
      this.s3,
      this.s4,
      this.s5,
      this.s6,
      this.s7,
      this.gender});
  TextStyle _textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
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
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Choose one or more',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
          child: Column(
            children: [
              Container(
                decoration: boxDecorationPatient,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Long-Term Diseaes',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 30,
                      endIndent: 30,
                    ),
                    CheckboxListTile(
                        title: Text(
                          'Hypertension',
                          style: _textStyle,
                        ),
                        value: htnSelected,
                        onChanged: (val) {
                          setState(() {
                            htnSelected = val;
                            if (htnSelected) {
                              htn = 'HTN';
                            } else {
                              htn = null;
                            }
                          });
                        }),
                    CheckboxListTile(
                        title: Text('Diabetus Mellitus', style: _textStyle),
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
                        title: Text('Chronic Heart Disease', style: _textStyle),
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
                        title: Text('Heart Failure', style: _textStyle),
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
                        title:
                            Text('Chronic Kideny Disease', style: _textStyle),
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
                        title: Text('Liver Disease', style: _textStyle),
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
                        title: Text('Chronic Lung Disease', style: _textStyle),
                        value: cldSelected,
                        onChanged: (val) {
                          setState(() {
                            cldSelected = val;
                            if (cldSelected) {
                              cld = 'chronic lung disease';
                            } else {
                              cld = '';
                            }
                            print(cld);
                          });
                        }),
                    CheckboxListTile(
                        title: Text('COPD', style: _textStyle),
                        value: copdSelected,
                        onChanged: (val) {
                          setState(() {
                            copdSelected = val;
                            if (copdSelected) {
                              copd = 'chronic lung disease';
                            } else {
                              copd = '';
                            }
                            print(copd);
                          });
                        }),
                    CheckboxListTile(
                        title: Text('Asthma', style: _textStyle),
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
                        title: Text('Previous Goitre', style: _textStyle),
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
                        title: Text('Epilepsy', style: _textStyle),
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
                        title: Text('Chronic Intestinal Disease',
                            style: _textStyle),
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
                        title: Text('Stroke', style: _textStyle),
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
                        title: Text('Malignancy', style: _textStyle),
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
                decoration: boxDecorationPatient,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Life Style',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 30,
                      endIndent: 30,
                    ),
                    CheckboxListTile(
                        title: Text(
                          'Obesity',
                          style: _textStyle,
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
                        title: Text('Physical Inactivity', style: _textStyle),
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
                        title: Text('Pregnancy', style: _textStyle),
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
                        }),
                    CheckboxListTile(
                        title: Text('Alcoholism', style: _textStyle),
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
                        title: Text('Smoking', style: _textStyle),
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
                        title: Text('Family History', style: _textStyle),
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
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.maxFinite,
                child: RaisedButton.icon(
                  color: Colors.deepOrange,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  onPressed: () async {
                    maindisease1(
                        cc,
                        s2,
                        s3,
                        s4,
                        s5,
                        s6,
                        s7,
                        htn,
                        dm,
                        chd,
                        hf,
                        ctd,
                        ckd,
                        ld,
                        cid,
                        epilepsy,
                        cva,
                        goitre,
                        cld,
                        copd,
                        ashma,
                        malignancy,
                        pregnancy,
                        obesity,
                        inactivity,
                        familyHistory,
                        alcohol,
                        smoking,
                        gender);
                    maindisease6(
                        cc,
                        s2,
                        s3,
                        s4,
                        s5,
                        s6,
                        s7,
                        htn,
                        dm,
                        chd,
                        hf,
                        ctd,
                        ckd,
                        ld,
                        cid,
                        epilepsy,
                        cva,
                        goitre,
                        cld,
                        copd,
                        ashma,
                        malignancy,
                        pregnancy,
                        obesity,
                        inactivity,
                        familyHistory,
                        alcohol,
                        smoking,
                        gender);
                    maindisease3(
                        cc,
                        s2,
                        s3,
                        s4,
                        s5,
                        s6,
                        s7,
                        htn,
                        dm,
                        chd,
                        hf,
                        ctd,
                        ckd,
                        ld,
                        cid,
                        epilepsy,
                        cva,
                        goitre,
                        cld,
                        copd,
                        ashma,
                        malignancy,
                        pregnancy,
                        obesity,
                        inactivity,
                        familyHistory,
                        alcohol,
                        smoking,
                        gender);
                    maindisease4(
                        cc,
                        s2,
                        s3,
                        s4,
                        s5,
                        s6,
                        s7,
                        htn,
                        dm,
                        chd,
                        hf,
                        ctd,
                        ckd,
                        ld,
                        cid,
                        epilepsy,
                        cva,
                        goitre,
                        cld,
                        copd,
                        ashma,
                        malignancy,
                        pregnancy,
                        obesity,
                        inactivity,
                        familyHistory,
                        alcohol,
                        smoking,
                        gender);
                    maindisease5(
                        cc,
                        s2,
                        s3,
                        s4,
                        s5,
                        s6,
                        s7,
                        htn,
                        dm,
                        chd,
                        hf,
                        ctd,
                        ckd,
                        ld,
                        cid,
                        epilepsy,
                        cva,
                        goitre,
                        cld,
                        copd,
                        ashma,
                        malignancy,
                        pregnancy,
                        obesity,
                        inactivity,
                        familyHistory,
                        alcohol,
                        smoking,
                        gender);
                    maindisease7(
                        cc,
                        s2,
                        s3,
                        s4,
                        s5,
                        s6,
                        s7,
                        htn,
                        dm,
                        chd,
                        hf,
                        ctd,
                        ckd,
                        ld,
                        cid,
                        epilepsy,
                        cva,
                        goitre,
                        cld,
                        copd,
                        ashma,
                        malignancy,
                        pregnancy,
                        obesity,
                        inactivity,
                        familyHistory,
                        alcohol,
                        smoking,
                        gender);
                    maindisease2(
                        cc,
                        s2,
                        s3,
                        s4,
                        s5,
                        s6,
                        s7,
                        htn,
                        dm,
                        chd,
                        hf,
                        ctd,
                        ckd,
                        ld,
                        cid,
                        epilepsy,
                        cva,
                        goitre,
                        cld,
                        copd,
                        ashma,
                        malignancy,
                        pregnancy,
                        obesity,
                        inactivity,
                        familyHistory,
                        alcohol,
                        smoking,
                        gender);
                    Navigator.pushNamed(context, '/patient_get_location');
                  },
                  label: Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
