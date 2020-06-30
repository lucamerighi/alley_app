import 'package:alley_app/model/data.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/registrasquadra_db.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:alley_app/shared/styles.dart';
import 'package:flutter/material.dart';

class ViewRegistraSquadra extends StatefulWidget {
  final Function toggleView;

  ViewRegistraSquadra({this.toggleView});
  @override
  _ViewRegistraSquadraState createState() => _ViewRegistraSquadraState();
}

class _ViewRegistraSquadraState extends State<ViewRegistraSquadra> {
  final _formKey = GlobalKey<FormState>();
  String uid = getIt<DatabaseService>().currentUser.uid;
  final RegistraSquadraDbService _registraSquadraDbService = getIt<RegistraSquadraDbService>();
  bool loading = false;

  String regione = 'AB';
  String idSquadra = '';
  String nome = '';
  String girone = '';
  Sesso sesso = Sesso.M;
  String campionato = 'D';
  Ruolo ruolo = Ruolo.Coach;
  String error = '';

  static const padding = 25.0;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Registra Squadra',
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: padding),
                      DropdownButtonFormField<String>(
                        hint: Text('Regione: '),
                        value: regione,
                        items: regioni
                            .map((nome, sigla) {
                              return MapEntry(
                                nome,
                                DropdownMenuItem<String>(
                                  value: sigla,
                                  child: Text(nome),
                                ),
                              );
                            })
                            .values
                            .toList(),
                        onChanged: (newVal) {
                          setState(() {
                            regione = newVal;
                          });
                        },
                      ),
                      SizedBox(height: padding),
                      TextFormField(
                        decoration: TextInputDecoration.copyWith(hintText: 'Id Squadra'),
                        validator: (value) => value.length != 5 ? 'L\'ID dev\'essere composto da 5 cifre' : null,
                        onChanged: (value) {
                          setState(() => idSquadra = value);
                        },
                      ),
                      SizedBox(height: padding),
                      TextFormField(
                        decoration: TextInputDecoration.copyWith(hintText: 'Nome Squadra'),
                        validator: (value) => value.isEmpty ? 'Inserire il nome' : null,
                        onChanged: (value) {
                          setState(() => nome = value);
                        },
                      ),
                      SizedBox(height: padding),
                      TextFormField(
                        decoration: TextInputDecoration.copyWith(hintText: 'Girone'),
                        validator: (value) => value.isEmpty ? 'Inserire il girone' : null,
                        onChanged: (value) {
                          setState(() => girone = value);
                        },
                      ),
                      SizedBox(height: padding),
                      DropdownButtonFormField<String>(
                        hint: Text('Campionato: '),
                        value: campionato,
                        items: campionati
                            .map((nome, sigla) {
                              return MapEntry(
                                nome,
                                DropdownMenuItem<String>(
                                  value: sigla,
                                  child: Text(nome),
                                ),
                              );
                            })
                            .values
                            .toList(),
                        onChanged: (newVal) {
                          setState(() {
                            campionato = newVal;
                          });
                        },
                      ),
                      SizedBox(height: padding),
                      Row(
                        children: <Widget>[
                          Radio(
                              value: Sesso.M,
                              groupValue: sesso,
                              onChanged: (Sesso s) => {
                                    setState(() => {sesso = s})
                                  }),
                          Text("Maschile"),
                          Radio(
                              value: Sesso.F,
                              groupValue: sesso,
                              onChanged: (Sesso s) => {
                                    setState(() => {sesso = s})
                                  }),
                          Text("Femminile"),
                        ],
                      ),
                      RaisedButton(
                        color: Colors.orange[600],
                        child: Text(
                          'Registra Squadra',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            bool result = await _registraSquadraDbService.registerTeam(
                                idSquadra, regione, nome, girone, sesso, campionato, uid);
                            setState(() {
                              loading = false;
                            });
                            if (result) {
                              Navigator.pop(context);
                            } else {
                              error = 'Squadra già registrata. Cambiare id squadra';
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
