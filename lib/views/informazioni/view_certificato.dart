import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewCertificato extends StatefulWidget {
  @override
  _ViewCertificatoState createState() => _ViewCertificatoState();
}

class _ViewCertificatoState extends State<ViewCertificato> {
  DateTime data = DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
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
              formatter.format(data.toLocal()),
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
