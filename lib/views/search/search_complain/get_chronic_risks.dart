import 'package:flutter/material.dart';
import 'package:project_doctor/constants/color_style_size.dart';
import 'package:project_doctor/custom_widges/custom_buttons.dart';
import 'package:project_doctor/custom_widges/custom_scaffold.dart';
import 'package:project_doctor/matching_algorithm/disease1.dart';
import 'package:project_doctor/matching_algorithm/disease2.dart';
import 'package:project_doctor/matching_algorithm/disease3.dart';
import 'package:project_doctor/matching_algorithm/disease4.dart';
import 'package:project_doctor/matching_algorithm/disease5.dart';
import 'package:project_doctor/matching_algorithm/disease6.dart';
import 'package:project_doctor/matching_algorithm/disease7.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_doctor/generated/locale_keys.g.dart';
import 'package:project_doctor/views/search/search_complain/result_speciality.dart';

class ChronicDiseaseRiskFactorView extends StatefulWidget {
  final String chiefcomplaint;
  final String sym2;
  final String sym3;
  final String sym4;
  final String sym5;
  final String sym6;
  final String sym7;
  final String gender;
  ChronicDiseaseRiskFactorView({this.chiefcomplaint, this.sym2, this.sym3, this.sym4, this.sym5, this.sym6, this.sym7, this.gender});
  @override
  _ChronicDiseaseRiskFactorViewState createState() =>
      _ChronicDiseaseRiskFactorViewState(cc: chiefcomplaint, s2: sym2, s3: sym3, s4: sym4, s5: sym5, s6: sym6, s7: sym7, gender: gender);
}

class _ChronicDiseaseRiskFactorViewState extends State<ChronicDiseaseRiskFactorView> {
  String cc;
  String s2;
  String s3;
  String s4;
  String s5;
  String s6;
  String s7;
  String gender;
  _ChronicDiseaseRiskFactorViewState({this.cc, this.s2, this.s3, this.s4, this.s5, this.s6, this.s7, this.gender});

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
    return BaseScaffold(
      title: 'choose_one_more'.tr(),
      isAppbar: true,
      action: getAppActions(context),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: getDeviceType(context, 15, 25, 50, 70)),
              child: BaseButton(
                title: LocaleKeys.view_buttons_next.tr(),
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SpecialityResultView()));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: getDeviceType(context, 15, 25, 50, 75)),
            child: Container(
              width: getDeviceType(context, 275, 350, 450, 550),
              height: getDeviceType(context, 425, 650, 750, 1000),
              child: Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: CustomStyle.box,
                      padding: EdgeInsets.all(getDeviceType(context, 4, 8, 16, 24)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: getDeviceType(context, 8, 16, 24, 32)),
                            child: Text(
                              'chronic_disease'.tr(),
                              style: CustomStyle.getTitleBlack(context),
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
                                'cd_HTN'.tr(),
                                style: CustomStyle.getSubtitle(context),
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
                              title: Text(
                                "cd_DM".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_heart".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_heartFailure".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_ctd".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_ckd".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_liver".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_lung".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_ashma".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_thyroid".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_epilepsy".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_intestine".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_cva".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "cd_tumor".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                    SizedBox(height: getDeviceType(context, 8, 16, 24, 32)),
                    Container(
                      decoration: CustomStyle.box,
                      padding: EdgeInsets.all(getDeviceType(context, 4, 8, 16, 24)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: getDeviceType(context, 15, 25, 50, 70)),
                            child: Text(
                              'life_style'.tr(),
                              style: CustomStyle.getTitleBlack(context),
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
                                'obesity'.tr(),
                                style: CustomStyle.getSubtitle(context),
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
                              title: Text(
                                "physical_inactive".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "alcohol".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "smoking".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                              title: Text(
                                "family".tr(),
                                style: CustomStyle.getSubtitle(context),
                              ),
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
                                  title: Text(
                                    "pregnancy".tr(),
                                    style: CustomStyle.getSubtitle(context),
                                  ),
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
            ),
          ),
        ],
      ),
    );
  }
}
