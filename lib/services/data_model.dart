// user data model;
class UserID {
  final String uid;

  UserID({this.uid});
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

class Info {
  final String name;
  final String speciality;
  final String phoneNumber;
  final String province;
  final String location;

  Info(
      {this.name,
      this.speciality,
      this.phoneNumber,
      this.province,
      this.location});
}
