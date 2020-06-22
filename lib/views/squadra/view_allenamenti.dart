import 'package:alley_app/model/allenamento.dart';
import 'package:alley_app/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd/MM/yy hh:mm');

class ViewAllenamenti extends StatefulWidget {
  @override
  _ViewAllenamentiState createState() => _ViewAllenamentiState();
}

class _ViewAllenamentiState extends State<ViewAllenamenti> {
  List<Allenamento> allenamenti = [
    Allenamento(
        dataEORa: DateTime.parse('2020-04-01 20:30'),
        luogo: 'Via di Qua, 7, Bologna',
        idSquadra: '00001',
        turnoCibo: 'Caio'),
    Allenamento(dataEORa: DateTime.parse('2020-04-03 20:30'), luogo: 'Via di Qua, 7, Bologna', idSquadra: '00001'),
    Allenamento(dataEORa: DateTime.parse('2020-04-04 20:30'), luogo: 'Via di Qua, 7, Bologna', idSquadra: '00001'),
    Allenamento(dataEORa: DateTime.parse('2020-04-06 20:30'), luogo: 'Via di Qua, 7, Bologna', idSquadra: '00001'),
  ];

  void _editDateTime(Allenamento a) {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true, minTime: a.dataEORa, maxTime: a.dataEORa.add(Duration(days: 365)), onConfirm: (date) {
      setState(() {
        allenamenti.firstWhere((all) => all.id == a.id).dataEORa = date;
      });
    }, locale: LocaleType.it);
  }

  void _showEditAllenamento(Allenamento a) {
    TextEditingController _controller = TextEditingController(text: a.luogo);

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${formatter.format(a.dataEORa)}'),
                    RaisedButton(
                      onPressed: () => _editDateTime(a),
                      child: Text('Cambia'),
                      color: Colors.orangeAccent,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: TextInputDecoration,
                  controller: _controller,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.redAccent,
                      child: Text('Elimina'),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.orangeAccent,
                      child: Text('Conferma'),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Allenamenti')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.grey[700],
              ),
              itemCount: allenamenti.length,
              itemBuilder: (BuildContext ctx, int index) {
                Allenamento all = allenamenti[index];
                print(all);
                return InkWell(
                  onTap: () => _showEditAllenamento(all),
                  child: ListTile(
                    title: Text(formatter.format(all.dataEORa)),
                    subtitle: Text(all.luogo + (all.turnoCibo != '' ? '\nTurno Cibo: ${all.turnoCibo}' : '')),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showEditAllenamento(Allenamento()),
        child: Icon(Icons.add),
      ),
    );
  }
}
