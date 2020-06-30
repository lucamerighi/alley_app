import 'package:alley_app/services/certificato_db.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewCertificato extends StatefulWidget {
  @override
  _ViewCertificatoState createState() => _ViewCertificatoState();
}

class _ViewCertificatoState extends State<ViewCertificato> {
  final DatabaseService _dbService = getIt<DatabaseService>();
  final CertificatoDbService _certificatoDbService = getIt<CertificatoDbService>();
  DateTime data;
  var formatter = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    data = _dbService.currentUser.scadenzaCertificato;
  }

  @override
  Widget build(BuildContext context) {
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: data ?? DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != data) {
        setState(() {
          data = picked;
        });
        _certificatoDbService.updateCertificato(picked, _dbService.currentUser);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Certificato Medico'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Scadenza attuale del certificato: ',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              data != null ? formatter.format(data) : 'Data assente',
              style: TextStyle(color: Colors.red, fontSize: 24),
            ),
            SizedBox(height: 60),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Aggiorna Certificato'),
              color: Colors.orangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
