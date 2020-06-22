import 'package:flutter/material.dart';

List<String> certificati = [
  'Nome Cognome (Display) Scaduto - 10/5/2020',
  'Nome Cognome (Display) Valido - 4/12/2021',
];

class ViewCertificati extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificati: '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemBuilder: (context, index) {
              String c = certificati[index];
              return Container(
                height: 50,
                child: Card(
                  color: c.endsWith('2020') ? Colors.red : Colors.green,
                  child: Center(
                      child: Text(
                    c,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              );
            },
            itemCount: certificati.length),
      ),
    );
  }
}
