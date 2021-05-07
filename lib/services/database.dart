import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/views/auth/email_verify_view.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  static String province = '';
  static String preDeleteProvince = '';
  static String validationProvince = '';
  final CollectionReference baghdadCollection =
      FirebaseFirestore.instance.collection('doctorInfo');

  final CollectionReference babilCollection =
      FirebaseFirestore.instance.collection('babilDoctorInfo');

  final CollectionReference basrahCollection =
      FirebaseFirestore.instance.collection('basrahDoctorInfo');

  final CollectionReference erbilCollection =
      FirebaseFirestore.instance.collection('erbilDoctorInfo');

  final CollectionReference duhokCollection =
      FirebaseFirestore.instance.collection('duhokDoctorInfo');

  final CollectionReference suleymaniahCollection =
      FirebaseFirestore.instance.collection('suleymaniahDoctorInfo');

  final CollectionReference kirkokCollection =
      FirebaseFirestore.instance.collection('kirkokDoctorInfo');

  final CollectionReference diyalaCollection =
      FirebaseFirestore.instance.collection('diyalaDoctorInfo');

  final CollectionReference saladinCollection =
      FirebaseFirestore.instance.collection('saladinDoctorInfo');

  final CollectionReference ninvehCollection =
      FirebaseFirestore.instance.collection('ninvehDoctorInfo');

  final CollectionReference anbarCollection =
      FirebaseFirestore.instance.collection('anbarDoctorInfo');

  final CollectionReference karbalaCollection =
      FirebaseFirestore.instance.collection('karbalaDoctorInfo');

  final CollectionReference wasitCollection =
      FirebaseFirestore.instance.collection('wasitDoctorInfo');

  final CollectionReference najafCollection =
      FirebaseFirestore.instance.collection('najafDoctorInfo');

  final CollectionReference maysanCollection =
      FirebaseFirestore.instance.collection('maysanDoctorInfo');

  final CollectionReference dhiqarCollection =
      FirebaseFirestore.instance.collection('dhiqarDoctorInfo');

  final CollectionReference muthanaCollection =
      FirebaseFirestore.instance.collection('muthanaDoctorInfo');

  final CollectionReference qadiseyahCollection =
      FirebaseFirestore.instance.collection('qadiseyahDoctorInfo');

//Collections for our own database========

  final CollectionReference baghdadBasicCollection =
      FirebaseFirestore.instance.collection('basicData');

  final CollectionReference babilBasicCollection =
      FirebaseFirestore.instance.collection('babilBasicData');

  final CollectionReference basrahBasicCollection =
      FirebaseFirestore.instance.collection('basrahBasicData');

  final CollectionReference erbilBasicCollection =
      FirebaseFirestore.instance.collection('erbilBasicData');

  final CollectionReference duhokBasicCollection =
      FirebaseFirestore.instance.collection('duhokBasicData');

  final CollectionReference suleymaniahBasicCollection =
      FirebaseFirestore.instance.collection('suleymaniahBasicData');

  final CollectionReference kirkokBasicCollection =
      FirebaseFirestore.instance.collection('kirkokBasicData');

  final CollectionReference diyalaBasicCollection =
      FirebaseFirestore.instance.collection('diyalaBasicData');

  final CollectionReference saladinBasicCollection =
      FirebaseFirestore.instance.collection('saladinBasicData');

  final CollectionReference ninevehBasicCollection =
      FirebaseFirestore.instance.collection('ninevehBasicData');

  final CollectionReference anbarBasicCollection =
      FirebaseFirestore.instance.collection('anbarBasicData');

  final CollectionReference karbalaBasicCollection =
      FirebaseFirestore.instance.collection('karbalaBasicData');

  final CollectionReference wasitBasicCollection =
      FirebaseFirestore.instance.collection('wasitBasicData');

  final CollectionReference najafBasicCollection =
      FirebaseFirestore.instance.collection('najafBasicData');

  final CollectionReference dhiqarBasicCollection =
      FirebaseFirestore.instance.collection('maysanBasicData');

  final CollectionReference maysanBasicCollection =
      FirebaseFirestore.instance.collection('dhiqarBasicData');

  final CollectionReference muthanaBasicCollection =
      FirebaseFirestore.instance.collection('muthanaBasicData');

  final CollectionReference qadiseyahBasicCollection =
      FirebaseFirestore.instance.collection('qadiseyahBasicData');

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
    if (EmailVerification.province == 'Baghdad') {
      return await baghdadCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Babil') {
      return await babilCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Basra') {
      return await basrahCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Erbil') {
      return await erbilCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Duhok') {
      return await duhokCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Sulaymaniyah') {
      return await suleymaniahCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Kirkuk') {
      return await kirkokCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Diyala') {
      return await diyalaCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Saladin') {
      return await saladinCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Nineveh') {
      return await ninvehCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Al Anbar') {
      return await anbarCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Karbala') {
      return await karbalaCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Wasit') {
      return await wasitCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Najaf') {
      return await najafCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Dhi Qar') {
      return await dhiqarCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Maysan') {
      return await maysanCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Muthanna') {
      return await muthanaCollection.doc(uid).set({
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
    } else if (EmailVerification.province == 'Al Qadisiyyah') {
      return await qadiseyahCollection.doc(uid).set({
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
  // ignore: missing_return
  Future deleteuser() {
    if (DatabaseService.preDeleteProvince == 'Baghdad') {
      return baghdadCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Babil') {
      return babilCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Basra') {
      return basrahCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Erbil') {
      return erbilCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Duhok') {
      return duhokCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Sulaymaniyah') {
      return suleymaniahCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Kirkuk') {
      return kirkokCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Diyala') {
      return diyalaCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Saladin') {
      return saladinCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Nineveh') {
      return ninvehCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Al Anbar') {
      return anbarCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Karbala') {
      return karbalaCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Wasit') {
      return wasitCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Najaf') {
      return najafCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Dhi Qar') {
      return dhiqarCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Maysan') {
      return maysanCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Muthanna') {
      return muthanaCollection.doc(uid).delete();
    } else if (DatabaseService.preDeleteProvince == 'Al Qadisiyyah') {
      return qadiseyahCollection.doc(uid).delete();
    }
  }

  //===========end============
  // stream to get userdata from a snapshot and map it to a model data.
  Stream<QuerySnapshot> get baghdadDoctorDataProfileStream {
    return baghdadCollection.snapshots();
  }

  Stream<QuerySnapshot> get babilDoctorDataProfileStream {
    return babilCollection.snapshots();
  }

  Stream<QuerySnapshot> get basrahDoctorDataProfileStream {
    return basrahCollection.snapshots();
  }

  Stream<QuerySnapshot> get erbilDoctorDataProfileStream {
    return erbilCollection.snapshots();
  }

  Stream<QuerySnapshot> get kirkokDoctorDataProfileStream {
    return kirkokCollection.snapshots();
  }

  Stream<QuerySnapshot> get duhokDoctorDataProfileStream {
    return duhokCollection.snapshots();
  }

  Stream<QuerySnapshot> get sulaymaniahDoctorDataProfileStream {
    return suleymaniahCollection.snapshots();
  }

  Stream<QuerySnapshot> get diyalaDoctorDataProfileStream {
    return diyalaCollection.snapshots();
  }

  Stream<QuerySnapshot> get saladinDoctorDataProfileStream {
    return saladinCollection.snapshots();
  }

  Stream<QuerySnapshot> get ninevehDoctorDataProfileStream {
    return ninvehCollection.snapshots();
  }

  Stream<QuerySnapshot> get anbarDoctorDataProfileStream {
    return anbarCollection.snapshots();
  }

  Stream<QuerySnapshot> get karbalaDoctorDataProfileStream {
    return karbalaCollection.snapshots();
  }

  Stream<QuerySnapshot> get wasitDoctorDataProfileStream {
    return wasitCollection.snapshots();
  }

  Stream<QuerySnapshot> get najafDoctorDataProfileStream {
    return najafCollection.snapshots();
  }

  Stream<QuerySnapshot> get maysanDoctorDataProfileStream {
    return maysanCollection.snapshots();
  }

  Stream<QuerySnapshot> get dhiqarDoctorDataProfileStream {
    return dhiqarCollection.snapshots();
  }

  Stream<QuerySnapshot> get muthanaDoctorDataProfileStream {
    return muthanaCollection.snapshots();
  }

  Stream<QuerySnapshot> get qadiseyahoctorDataProfileStream {
    return qadiseyahCollection.snapshots();
  }

  //==================================
  // ignore: missing_return
  Stream<QuerySnapshot> get usersDataStream {
    if (DatabaseService.province == 'Baghdad') {
      return baghdadCollection.snapshots();
    } else if (DatabaseService.province == 'Babil') {
      return babilCollection.snapshots();
    } else if (DatabaseService.province == 'Basra') {
      return basrahCollection.snapshots();
    } else if (DatabaseService.province == 'Erbil') {
      return erbilCollection.snapshots();
    } else if (DatabaseService.province == 'Duhok') {
      return duhokCollection.snapshots();
    } else if (DatabaseService.province == 'Sulaymaniyah') {
      return suleymaniahCollection.snapshots();
    } else if (DatabaseService.province == 'Kirkuk') {
      return kirkokCollection.snapshots();
    } else if (DatabaseService.province == 'Diyala') {
      return diyalaCollection.snapshots();
    } else if (DatabaseService.province == 'Saladin') {
      return saladinCollection.snapshots();
    } else if (DatabaseService.province == 'Nineveh') {
      return ninvehCollection.snapshots();
    } else if (DatabaseService.province == 'Al Anbar') {
      return anbarCollection.snapshots();
    } else if (DatabaseService.province == 'Karbala') {
      return karbalaCollection.snapshots();
    } else if (DatabaseService.province == 'Wasit') {
      return wasitCollection.snapshots();
    } else if (DatabaseService.province == 'Najaf') {
      return najafCollection.snapshots();
    } else if (DatabaseService.province == 'Dhi Qar') {
      return dhiqarCollection.snapshots();
    } else if (DatabaseService.province == 'Maysan') {
      return maysanCollection.snapshots();
    } else if (DatabaseService.province == 'Muthanna') {
      return muthanaCollection.snapshots();
    } else if (DatabaseService.province == 'Al Qadisiyyah') {
      return qadiseyahCollection.snapshots();
    }
  }

  // stream to get user data
  Stream<UpdateUserDataModel> get doctorDataFormStream {
    return baghdadCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<QuerySnapshot> get doccCol {
    return baghdadCollection.snapshots();
  }

  // ignore: missing_return
  Stream<QuerySnapshot> get basicData {
    if (DatabaseService.validationProvince == 'Baghdad') {
      return baghdadBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Babil') {
      return babilBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Basra') {
      return basrahBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Erbil') {
      return erbilBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Duhok') {
      return duhokBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Sulaymaniyah') {
      return suleymaniahBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Kirkuk') {
      return kirkokBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Diyala') {
      return diyalaBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Saladin') {
      return saladinBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Nineveh') {
      return ninevehBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Al Anbar') {
      return anbarBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Karbala') {
      return karbalaBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Wasit') {
      return wasitBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Najaf') {
      return najafBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Dhi Qar') {
      return dhiqarBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Maysan') {
      return maysanBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Muthanna') {
      return muthanaBasicCollection.snapshots();
    } else if (DatabaseService.validationProvince == 'Al Qadisiyyah') {
      return qadiseyahBasicCollection.snapshots();
    }
  }
}
