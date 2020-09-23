// user data model;
class UserIDModel {
  final String uid;

  UserIDModel({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  final String location;

  UserData(
      {this.uid,
      this.name,
      this.speciality,
      this.phoneNumber,
      this.province,
      this.location});
}

class DoctorDataListModel {
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  final String location;

  DoctorDataListModel(
      {this.name,
      this.speciality,
      this.phoneNumber,
      this.province,
      this.location});
}
