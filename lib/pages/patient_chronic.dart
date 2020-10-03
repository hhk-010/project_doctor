import 'package:flutter/material.dart';
import 'package:project_doctor/constants/theme.dart';

class PatientChronicDiseases extends StatefulWidget {
  @override
  _PatientChronicDiseasesState createState() =>
      new _PatientChronicDiseasesState();
}

class _PatientChronicDiseasesState extends State<PatientChronicDiseases> {
  List _selecteCategorys = List();

  Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "1", "category_name": "Elevated Blood Pressure"},
      {"category_id": "2", "category_name": "Diabetus Mellitus"},
      {"category_id": "3", "category_name": "Chronic Heart Disease"},
      {"category_id": "4", "category_name": "Heart Failure"},
      {"category_id": "5", "category_name": "Connective tissue disease"},
      {"category_id": "6", "category_name": "Kidney Diseae"},
      {"category_id": "7", "category_name": "Liver Disease"},
      {"category_id": "8", "category_name": "Chronic Intestinal Disease"},
      {"category_id": "9", "category_name": "Epilespy"},
      {"category_id": "10", "category_name": "Stroke"},
      {"category_id": "11", "category_name": "Previous Goitre"},
      {"category_id": "12", "category_name": "Chronic Lung Disease"},
      {"category_id": "13", "category_name": "COPD"},
      {"category_id": "14", "category_name": "Ashma"},
      {"category_id": "15", "category_name": "Malignancy"},
    ],
    "responseTotalResult":
        15 // Total result is 3 here becasue we have 3 categories in responseBody.
  };

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Long-Term Diseaes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: boxDecorationPatient,
          child: ListView.builder(
              itemCount: _categories['responseTotalResult'],
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  value: _selecteCategorys.contains(
                      _categories['responseBody'][index]['category_id']),
                  onChanged: (bool selected) {
                    _onCategorySelected(selected,
                        _categories['responseBody'][index]['category_id']);
                  },
                  title:
                      Text(_categories['responseBody'][index]['category_name']),
                );
              }),
        ),
      ),
    );
  }
}
