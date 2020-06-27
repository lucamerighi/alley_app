import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/styles.dart';
import 'package:flutter/material.dart';

class AggiungiGiocatoreForm extends StatefulWidget {
  @override
  _AggiungiGiocatoreFormState createState() => _AggiungiGiocatoreFormState();
}

class _AggiungiGiocatoreFormState extends State<AggiungiGiocatoreForm> {
  final _formKey = GlobalKey<FormState>();
  final dbService = getIt<DatabaseService>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: TextInputDecoration.copyWith(hintText: 'Email Giocatore'),
            validator: (val) => val.isEmpty ? 'Inserire una mail valida' : null,
            onChanged: (val) => setState(() => email = val),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            color: Colors.orangeAccent,
            child: Text(
              'Aggiungi',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              dbService.addPlayer(email);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
