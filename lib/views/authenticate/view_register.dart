import 'package:alley_app/model/data.dart';
import 'package:alley_app/services/auth.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:alley_app/shared/styles.dart';
import 'package:flutter/material.dart';

class ViewRegister extends StatefulWidget {
  final Function toggleView;

  ViewRegister({this.toggleView});
  @override
  _ViewRegisterState createState() => _ViewRegisterState();
}

class _ViewRegisterState extends State<ViewRegister> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String nome = '';
  String cognome = '';
  Ruolo ruolo = Ruolo.Coach;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
                title: Text(
                  'Registra',
                ),
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () => widget.toggleView(),
                    icon: Icon(Icons.person),
                    label: Text('Login'),
                  )
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: TextInputDecoration.copyWith(hintText: 'Email'),
                        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      SizedBox(height: 20.0),
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
                      TextFormField(
                        decoration: TextInputDecoration.copyWith(hintText: 'Nome'),
                        validator: (value) => value.isEmpty ? 'Inserire il nome' : null,
                        onChanged: (value) {
                          setState(() => nome = value);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: TextInputDecoration.copyWith(hintText: 'Cognome'),
                        validator: (value) => value.isEmpty ? 'Inserire il cognome' : null,
                        onChanged: (value) {
                          setState(() => cognome = value);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                        Radio(
                          value: Ruolo.Coach,
                          groupValue: ruolo,
                          onChanged: (Ruolo r) {
                            setState(() {
                              ruolo = r;
                            });
                          },
                        ),
                        Text(
                          'Coach',
                        ),
                        Radio(
                          value: Ruolo.Giocatore,
                          groupValue: ruolo,
                          onChanged: (Ruolo r) {
                            setState(() {
                              ruolo = r;
                            });
                          },
                        ),
                        Text(
                          'Giocatore',
                        ),
                      ]),
                      RaisedButton(
                        color: Colors.orange[600],
                        child: Text(
                          'Crea account',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.registerUser(email, password, nome, cognome, 'test', ruolo);
                            if (result == null) {
                              setState(() {
                                error = 'please supply a valid email';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      Text(error)
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
