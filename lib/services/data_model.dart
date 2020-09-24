// user data model;
class UserID {
  final String uid;

  UserID({this.uid});
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

class UpdateUserDataModel {
  final String uid;
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  final String location;

  UpdateUserDataModel(
      {this.uid,
      this.name,
      this.speciality,
      this.phoneNumber,
      this.province,
      this.location});
}
