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

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create a new document for the user with the id
      await DatabaseService(uid: user.uid).updateUserData('', '', '', '', '');
      return _userfromfirebase(user);
    } catch (e) {
      print(e.toString());
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
}
