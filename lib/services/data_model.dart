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

class Favorite {
  static String favorite01 = '';
  static String favorite02 = '';
  static String favorite03 = '';
  static String favorite04 = '';
  static String favorite05 = '';
  static String favorite06 = '';
  static String favorite07 = '';
  static String favorite08 = '';
  static String favorite09 = '';
  static String favorite10 = '';
  static List favoriteIdlist = [];
  static List favoriteList01 = [];
  static List favoriteList02 = [];
  static List favoriteList03 = [];
  static List favoriteList04 = [];
  static List favoriteList05 = [];
  static List favoriteList06 = [];
  static List favoriteList07 = [];
  static List favoriteList08 = [];
  static List favoriteList09 = [];
  static List favoriteList10 = [];
  static List favoriteList11 = [];
  static List favoriteList12 = [];
  static List favoriteList13 = [];
  static List favoriteList14 = [];
  static List favoriteList15 = [];
  static List favoriteList16 = [];
  static List favoriteList17 = [];
  static List favoriteList18 = [];
}

class FavoriteListData {
  var id;
  final String name;
  final String address;
  final String speciality;
  final String province;
  final String phoneNumber;
  final List workDays01;
  final List workDays02;
  final List workDays03;
  final double lat;
  final double lng;
  FavoriteListData(
      {this.id,
      this.name,
      this.address,
      this.speciality,
      this.province,
      this.phoneNumber,
      this.workDays01,
      this.workDays02,
      this.workDays03,
      this.lat,
      this.lng});
}
