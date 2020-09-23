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

  // stream to get userdata from a snapshot and map it to a model data.
  Stream<List<DoctorDataListModel>> get doctorDataStream {
    return userCollection.snapshots().map(_doctorDataListFromSnapshot);
  }

  // doctordatalist model data from snapshot
  List<DoctorDataListModel> _doctorDataListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DoctorDataListModel(
        name: doc.data()['name'] ?? '',
        speciality: doc.data()['speciality'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
        province: doc.data()['province'] ?? '',
        location: doc.data()['location'] ?? '',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      speciality: snapshot.data()['speciality'],
    );
  }

  Stream<UserData> get userDate {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
