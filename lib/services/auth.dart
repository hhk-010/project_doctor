import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_doctor/services/data_model.dart';
import 'package:project_doctor/services/database.dart';
import 'auth_exception_handling.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthResultStatus _status;

  UserID _userfromfirebase(User user) {
    return user != null ? UserID(uid: user.uid) : null;
  }

  Stream<UserID> get user {
    return _auth.authStateChanges().map((User user) => _userfromfirebase(user));
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
      return _userfromfirebase(user);
    } catch (e) {
      print('Exception @createAccount: $e');
      print(_status);
      _status = AuthExceptionHandler.handleException(e);
      return null;
    }
    //return _status;
  }

  Future registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = authResult.user;
      // create a new document for the user with the id
      await user.sendEmailVerification();
      /*if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }*/

      return _userfromfirebase(user);
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
      //return _status;
      return null;
    }
  }

  resendemail() {
    User user = FirebaseAuth.instance.currentUser;
    try {
      user.sendEmailVerification();
    } catch (e) {
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

  passwordisvalid(String passwords) async {
    return await AuthService().validatepass(passwords);
  }

  Future<bool> validatepass(String pass) async {
    User user = _auth.currentUser;
    AuthCredential credentials = EmailAuthProvider.credential(email: user.email, password: pass);
    try {
      UserCredential cred = await user.reauthenticateWithCredential(credentials);
      return cred.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void updatepass(String password) {
    User user = FirebaseAuth.instance.currentUser;
    user.updatePassword(password);
  }

  //============delete user===============
  Future deleteUser(String email, String password) async {
    try {
      User user = _auth.currentUser;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(user);
      UserCredential result = await user.reauthenticateWithCredential(credentials);
      await DatabaseService(uid: result.user.uid).deleteuser(); // called from database class
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //===============end====================
}
