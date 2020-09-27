import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: Text('Sign In'),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
                      SizedBox(
                        height: 60.0,
                      ),
                      RaisedButton(
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
                          await Navigator.pushNamed(context, '/doctor_profile');
                        },
                        color: Colors.deepOrange,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(error),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              widget.toogleView();
                            },
                            child: RichText(
                              text: new TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(text: 'Does not have account? '),
                                  new TextSpan(
                                      text: 'Register',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
  }
}
