import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_doctor/services/app_localizations.dart';
import 'package:project_doctor/services/theme_const.dart';
import 'package:project_doctor/services/dropdown_multi_selection.dart';

class PatientRisks extends StatefulWidget {
  @override
  _PatientRisksState createState() => _PatientRisksState();
}

class _PatientRisksState extends State<PatientRisks> {
  TextStyle _textStylePatient = TextStyle(
    fontSize: 18,
    color: Colors.black,
  );

  String chronic1 = '';
  String chronic2 = '';
  String chronic3 = '';
  void _showMultiSelect(BuildContext context) async {
    chronic1 = '';
    chronic2 = '';
    chronic3 = '';
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(
          1, AppLocalizations.of(context).translate('cd_hyt')),
      MultiSelectDialogItem(2, AppLocalizations.of(context).translate('cd_DM')),
      MultiSelectDialogItem(
          3, AppLocalizations.of(context).translate('cd_heart')),
      MultiSelectDialogItem(
          4, AppLocalizations.of(context).translate('cd_heart')),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      },
    );
    var mappy = {1: 'headache', 2: 'abdominal pain'};
    for (var x in selectedValues) {
      if (x == 1) {
        chronic1 = 'headache';
      }
      if (x == 2) {
        chronic2 = 'abdominal pain';
      }
      if (x == 3) {
        chronic3 = 'chest pain';
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
  bool smoking=false;
  bool alcoholism=false;
  bool physicalinactive=false;
  bool familyhistory=false;
  String pregnancies='';
  String obesities='';
  String smoke='';
  String alcohol='';
  String inactive='';
  String familyhx='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Fill The Data',style: TextStyle(fontSize: 25.0),),
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
                          Text(
                              AppLocalizations.of(context)
                                  .translate('patient_chronic_diseases'),
                              style: _textStylePatient),
                          SizedBox(
                            width: 50,
                          ),
                          FlatButton(
                            onPressed: () => _showMultiSelect(context),
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
                      Row(
                        children: [],
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
                        Text('Obesity',style: TextStyle(fontSize: 18.0),),
                        SizedBox(width: 12.0,),
                        Checkbox(value: obesity, onChanged:(val){
                          setState(() {
                            obesity=val;
                            if(obesity){
                              obesities='obesity';
                            }else{
                              obesities=null;
                            }
                            print(obesities);
                          });
                        }),
                        SizedBox(width: 22.0,),
                        Text('Physical inactivity',style: TextStyle(fontSize: 18.0),),
                        SizedBox(width: 12.0,),
                        Checkbox(value: physicalinactive,onChanged:(val){
                          setState(() {
                            physicalinactive=val;
                            if(physicalinactive){
                              inactive='physical inactivity';
                            }else{
                              inactive= '';
                            }
                            print(inactive);
                          });
                        },),
                      ],
                    ),
                    SizedBox(height: 12.0,),
                    Row(
                      children: [
                        Text('Pregnancy',style: TextStyle(fontSize: 18.0),),
                        SizedBox(width: 12.0,),
                        Checkbox(value: pregnancy, onChanged:(val){
                          setState(() {
                            pregnancy=val;
                            if(pregnancy){
                              pregnancies='pregnancy';
                            }else{
                              pregnancies='';
                            }
                            print(pregnancies);
                          });
                        }),
                        SizedBox(width: 22.0,),
                        Text('Alcoholism',style: TextStyle(fontSize: 18.0),),
                        SizedBox(width: 12.0,),
                        Checkbox(value: alcoholism,onChanged:(val){
                          setState(() {
                            alcoholism=val;
                            if(alcoholism){
                              alcohol='alcoholism';
                            }else{
                              alcohol='';
                            }
                            print(alcohol);
                          });
                        },),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      children: [
                        Text('Smoking',style: TextStyle(fontSize: 18.0),),
                        SizedBox(width: 12.0,),
                        Checkbox(value: smoking, onChanged:(val){
                          setState(() {
                            smoking=val;
                            if(smoking){
                              smoke='smoking';
                            }else{
                              smoke='';
                            }
                            print(smoke);
                          });
                        }),
                        SizedBox(width: 22.0,),
                        Text('Family history',style: TextStyle(fontSize: 18.0),),
                        SizedBox(width: 12.0,),
                        Checkbox(value: familyhistory,onChanged:(val){
                          setState(() {
                            familyhistory=val;
                            if(familyhistory){
                              familyhx='family history';
                            }else{
                              familyhx='';
                            }
                            print(familyhx);
                          });
                        },),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
