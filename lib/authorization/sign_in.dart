import 'package:flutter/material.dart';
import 'package:project_doctor/authorization/forget_password.dart';
import 'package:project_doctor/authorization/loading.dart';
import 'package:project_doctor/services/auth.dart';
import 'package:project_doctor/constants/theme.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  TextStyle _textStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text(
                'Sign In',
                style: _textStyle.copyWith(fontSize: 25.0),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            textInputdecoration.copyWith(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6 or long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.visiblePassword,
                        decoration:
                            textInputdecoration.copyWith(hintText: 'Password'),
                      ),
                      SizedBox(height: 250.0),
                      Container(
                        height: 40.0,
                        width: 200.0,
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(
                                () => loading = true,
                              );
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'could not signed in with those credentials';
                                  loading = false;
                                });
                              }
                            }
                          },
                          color: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          child: Text(
                            'Sign In',
                            style: _textStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      FlatButton.icon(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                        },
                        label: Text(
                          'Forget Your Password?',
                          style: _textStyle.copyWith(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                      Text(error),
                      SizedBox(
                        height: 50,
                      ),
                      Divider(color: Colors.black),
                      InkWell(
                        onTap: () {
                          widget.toogleView();
                        },
                        child: RichText(
                          text: TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Does not have account? '),
                              TextSpan(
                                  text: 'Register',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
