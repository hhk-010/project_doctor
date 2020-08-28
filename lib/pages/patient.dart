import 'package:flutter/material.dart';

class Patient extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Patient info'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {
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
