import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_doctor/services/database.dart';
import 'package:project_doctor/services/data_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserID _userfromfirebase(User user) {
    return user != null ? UserID(uid: user.uid) : null;
  }

  Stream<UserID> get user {
    return _auth.authStateChanges().map((User user) => _userfromfirebase(user));
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String Speciality,
      String number,
      String province,
      double lat,
      double lng) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create a new document for the user with the id
      await DatabaseService(uid: user.uid)
          .updateUserData(name,Speciality,number,province,lat,lng);
      await user.sendEmailVerification();
      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  resendemail(){
    User user = FirebaseAuth.instance.currentUser;
    try{
      user.sendEmailVerification();
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  passwordisvalid(String passwords)async{
    return await AuthService().validatepass(passwords);
  }

  Future<bool> validatepass(String pass) async {
    User user = await _auth.currentUser;
    AuthCredential credentials=EmailAuthProvider.credential(email: user.email, password: pass);
    try{
      UserCredential cred =
      await user.reauthenticateWithCredential(credentials);
      return cred.user != null;
    }catch(e){
      print(e);
      return false;
    }
  }
  void updatepass(String password){
    User user =FirebaseAuth.instance.currentUser;
    user.updatePassword(password);
  }
}
