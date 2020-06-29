import 'package:alley_app/model/convocazione.dart';
import 'package:flutter/material.dart';

// View della convocazione per il giocatore
class ShowConvocazione extends StatelessWidget {
  final List<Convocazione> convocati;

  const ShowConvocazione({Key key, this.convocati}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista convocati: '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: convocati.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              child: Card(
                  color: Colors.green,
                  child: Center(
                      child: Text(
                    convocati[index].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
            );
          },
        ),
      ),
    );
  }
}
