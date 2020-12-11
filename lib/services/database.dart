import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_doctor/services/data_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('doctorInfo');
//Collection for our own database======
  final CollectionReference basicCollection =
      FirebaseFirestore.instance.collection('basicData');

  Future updateUserData(
      String name,
      String speciality,
      String phoneNumber,
      String province,
      double lat,
      double lng,
      String address,
      List workDays01,
      List workDays02,
      List workDays03) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'speciality': speciality,
      'phoneNumber': phoneNumber,
      'province': province,
      'lat': lat,
      'lng': lng,
      'address': address,
      'workDays01': workDays01,
      'workDays02': workDays02,
      'workDays03': workDays03,
    });
  }

  UpdateUserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UpdateUserDataModel(
      uid: uid,
      name: snapshot.data()['name'],
      speciality: snapshot.data()['speciality'],
      phoneNumber: snapshot.data()['phoneNumber'],
      province: snapshot.data()['province'],
      location: snapshot.data()['location'],
    );
  }

  //========delete user=======
  Future deleteuser() {
    return userCollection.doc(uid).delete();
  }

  //===========end============
  // stream to get userdata from a snapshot and map it to a model data.
  Stream<QuerySnapshot> get doctorDataProfileStream {
    return userCollection.snapshots();
  }

  // stream to get user data
  Stream<UpdateUserDataModel> get doctorDataFormStream {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<QuerySnapshot> get doccCol {
    return userCollection.snapshots();
  }

  Stream<QuerySnapshot> get basicData {
    return basicCollection.snapshots();
  }
}
