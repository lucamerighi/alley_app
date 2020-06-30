import 'package:alley_app/model/riga_classifica.dart';
import 'package:flutter/material.dart';

var headers = ['#', 'Nome', 'Punti', 'Vinte', 'Perse'];

var righe = [
  RigaClassifica(1, "Ingegneri del Software", 70, 35, 15),
  RigaClassifica(2, "Amministratori di Sistemi", 68, 34, 16),
  RigaClassifica(3, "Sviluppatori Web", 60, 30, 20),
  RigaClassifica(4, "Code Monkeys", 50, 25, 25),
  RigaClassifica(5, "Programmatori INPS", 10, 5, 45),
  RigaClassifica(6, "Fisioterapisti", 2, 1, 49),
  RigaClassifica(7, "Architetti", 0, 0, 50),
];

class ViewClassifica extends StatefulWidget {
  @override
  _ViewClassificaState createState() => _ViewClassificaState();
}

class _ViewClassificaState extends State<ViewClassifica> {
  bool sort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Classifica'),
        ),
        body: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 30,
            sortColumnIndex: 0,
            sortAscending: true,
            columns: headers
                .map((h) => DataColumn(
                    label: Text(h, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))))
                .toList(),
            rows: _buildRows(righe),
          ),
        ));
  }

  List<DataRow> _buildRows(List<RigaClassifica> righe) {
    return righe.map((r) => _buildRow(r)).toList();
  }

  DataRow _buildRow(RigaClassifica riga) {
    return DataRow(cells: [
      DataCell(Text(
        riga.posizione.toString(),
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(Text(riga.nome)),
      DataCell(Text(riga.punti.toString())),
      DataCell(Text(riga.vinte.toString())),
      DataCell(Text(riga.perse.toString())),
    ]);
  }
}
