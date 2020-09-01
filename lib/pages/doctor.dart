import 'package:flutter/material.dart';
import 'package:project_doctor/services/controller_form.dart';
import 'package:project_doctor/services/feedback_form.dart';

class Doctor extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //TextFiled Controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController availableTimeController = TextEditingController();

  void _submitForm() {
    if (formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        specialityController.text,
        locationController.text,
        phoneNumberController.text,
        availableTimeController.text,
      );
      FormController formController = FormController((String response) {
        print(response);
        if (response == FormController.STATUS_SUCCESS) {
          _showSnackBar("Feedback Submitted");
        } else {
          _showSnackBar("Error Occured");
        }
      });
      _showSnackBar("Submitting Feedback");
      formController.submitForm(feedbackForm);
    }
  }

  _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'معلومات الطبيب',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    hintText: 'ادخل الاسم الثلاثي',
                  ),
                  textAlign: TextAlign.right,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'رجاء ادخل الاسم الثلاثي';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: specialityController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    hintText: 'ادخل اختصاصك الطبي',
                  ),
                  textAlign: TextAlign.right,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'رجاء ادخل اختصاصك الطبي';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: locationController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    hintText: 'ادخل موقع عيادلتك',
                  ),
                  textAlign: TextAlign.right,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'رجاء ادخل موقع عيادتك';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    hintText: 'ادخل رقم هاتف عيادتك',
                  ),
                  textAlign: TextAlign.right,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'رجاء ادخل رقم هاتف حجز عيادلتك';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: availableTimeController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    hintText: 'ادخل ',
                  ),
                  textAlign: TextAlign.right,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Available Time';
                    }
                    return null;
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.deepOrange,
                      onPressed: () {
                        _submitForm();
                        if (formKey.currentState.validate()) {}
                      },
                      child: Text(
                        'ارسل',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
