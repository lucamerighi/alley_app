import 'package:alley_app/services/auth.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:alley_app/shared/styles.dart';
import 'package:flutter/material.dart';

class ViewSignIn extends StatefulWidget {
  final Function toggleView;

  ViewSignIn({this.toggleView});

  @override
  _ViewSignInState createState() => _ViewSignInState();
}

class _ViewSignInState extends State<ViewSignIn> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Login'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => widget.toggleView(),
                  icon: Icon(Icons.person),
                  label: Text('Registra'),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: TextInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: TextInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value.length < 6 ? 'Password must be at least 6 long' : null,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.orange[400],
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Could not sign in with these credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    Text(error),
                  ],
                ),
              ),
            ),
          );
  }
}
