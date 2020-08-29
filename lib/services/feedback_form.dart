class FeedbackForm {
  String _name;
  String _speciality;
  String _location;
  String _phoneNumber;
  String _availableTime;

  FeedbackForm(this._name, this._speciality,this._location,this._availableTime, this._phoneNumber);

  String toParams() => "?name=$_name&speciality=$_speciality&location=$_location&phoneNumber=$_phoneNumber&availableTime=$_availableTime";

}