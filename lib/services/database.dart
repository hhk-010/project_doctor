import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_doctor/services/data_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('doctorInfo');

  Future updateUserData(String name, String speciality, String phoneNumber,
      String province, String location) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'speciality': speciality,
      'phoneNumber': phoneNumber,
      'province': province,
      'location': location
    });
  }

  // info list from a snapshot
  List<DoctorInfo> _infoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DoctorInfo(
        name: doc.data()['name'] ?? '',
        speciality: doc.data()['speciality'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
        province: doc.data()['province'] ?? '',
        location: doc.data()['location'] ?? '',
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      speciality: snapshot.data()['speciality'],
    );
  }

  Stream<List<DoctorInfo>> get doctorInfo {
    return userCollection.snapshots().map(_infoListFromSnapshot);
  }

  Stream<UserData> get userDate {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
