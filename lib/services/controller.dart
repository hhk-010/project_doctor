import 'package:project_doctor/services/feedback_form.dart';
import 'package:http/http.dart'as http;
import 'dart:convert' as convert;

class FormController {

  final void Function(String) callback;
  static const String URL = "https://script.google.com/macros/s/AKfycbyaqSCS5Vscsp0B-G6jvPITjK77f7t3VmLyUPHv9pf4zr5SzCjx/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm (FeedbackForm FeedbackForm) async {

    try{
      await http.get(
        URL + FeedbackForm.toParams()
      ).then((response){
        callback(convert.jsonDecode(response.body)['status']);
      });
    }
    catch(e){
      print (e);
    }
  }
}