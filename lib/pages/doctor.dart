import 'package:flutter/material.dart';
import 'package:project_doctor/services/controller.dart';
import 'package:project_doctor/services/feedback_form.dart';

class Doctor extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //TextFiled Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController specialityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController availableTimeController = TextEditingController();

  void _submitForm() {
    if (formKey.currentState.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        specialityController.text,
        locationController.text,
        phoneNumberController.text,
        availableTimeController.text,
      );
      FormController formController = FormController(
          (String response){
            print(response);
            if (response == FormController.STATUS_SUCCESS){
              _showSnackBar("Feedback Submitted");
            }else{
              _showSnackBar("Error Occured");
            }
          }
      );
      _showSnackBar("Submitting Feedback");
      formController.submitForm(feedbackForm);
      }
  }
  _showSnackBar (String message){
    final snackBar = SnackBar(content: Text(message),);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Doctor Info'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  hintText: 'Enter your Name',
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'Please enter your Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: specialityController,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  hintText: 'Enter your Speciality',
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'Please enter your Speciality';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: locationController,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  hintText: 'Enter your Location',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneNumberController,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  hintText: 'Enter your Phone number',
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'Please enter your Phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: availableTimeController,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  hintText: 'Enter your Available Time',
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'Please enter your Available Time';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {
                    _submitForm();
                    if (formKey.currentState.validate()){}
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
         ),
      ),
    );
  }
}
