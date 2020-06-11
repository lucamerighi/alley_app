import 'package:alley_app/model/riga_classifica.dart';
import 'package:flutter/material.dart';

var headers = ['#', 'Nome', 'Punti', 'Vinte', 'Perse'];

var righe = [
  RigaClassifica(1, "Nome Squadra Moolto Lungo", 70, 35, 15),
  RigaClassifica(2, "WEBKORNER-SICI FIDES MONTEVARC", 70, 35, 15),
  RigaClassifica(3, "Nome Squadra", 70, 35, 15),
  RigaClassifica(4, "Nome Squadra", 70, 35, 15),
  RigaClassifica(6, "Nome Squadra", 70, 35, 15),
  RigaClassifica(7, "Nome Squadra", 70, 35, 15),
  RigaClassifica(8, "Nome Squadra", 70, 35, 15),
  RigaClassifica(9, "Nome Squadra", 70, 35, 15),
  RigaClassifica(10, "Nome Squadra", 70, 35, 15),
  RigaClassifica(11, "Nome Squadra", 70, 35, 15),
  RigaClassifica(12, "Nome Squadra", 70, 35, 15),
  RigaClassifica(13, "Nome Squadra", 70, 35, 15),
  RigaClassifica(14, "Nome Squadra", 70, 35, 15),
  RigaClassifica(15, "Nome Squadra", 70, 35, 15),
  RigaClassifica(16, "Nome Squadra", 70, 35, 15),
  RigaClassifica(17, "Nome Squadra", 70, 35, 15),
  RigaClassifica(18, "Nome Squadra", 70, 35, 15),
  RigaClassifica(19, "Nome Squadra", 70, 35, 15),
  RigaClassifica(20, "Nome Squadra", 70, 35, 15),
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
