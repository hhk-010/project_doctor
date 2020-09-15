import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_doctor/services/data_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userInfo');

  Future updateUserData(String name, String speciality) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'speciality': speciality});
  }

  // info list from a snapshot
  List<Info> _infoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Info(
          name: doc.data()['name'] ?? '',
          speciality: doc.data()['speciality'] ?? '');
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

  Stream<List<Info>> get info {
    return userCollection.snapshots().map(_infoListFromSnapshot);
  }

  Stream<UserData> get userDate {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
