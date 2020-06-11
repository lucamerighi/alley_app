import 'package:alley_app/model/Allenamento.dart';
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
    Allenamento(DateTime.parse('2020-04-01 20:30'), "Via di Qua, 7, Bologna", "40017", ""),
    Allenamento(DateTime.parse('2020-04-04 20:30'), "Via di Qua, 7, Bologna", "40017", "Caio"),
    Allenamento(DateTime.parse('2020-04-07 20:30'), "Via di Qua, 7, Bologna", "40017", ""),
    Allenamento(DateTime.parse('2020-04-10 20:30'), "Via di Qua, 7, Bologna", "40017", ""),
    Allenamento(DateTime.parse('2020-04-12 20:30'), "Via di Qua, 7, Bologna", "40017", "Tizio"),
    Allenamento(DateTime.parse('2020-04-15 20:30'), "Via di Qua, 7, Bologna", "40017", ""),
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("${formatter.format(a.dataEORa)}"),
                    RaisedButton(onPressed: () => _editDateTime(a), child: Text('Cambia'))
                  ],
                ),
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
                return InkWell(
                  onTap: () => _showEditAllenamento(all),
                  child: ListTile(
                    title: Text(formatter.format(all.dataEORa)),
                    subtitle: Text(all.luogo + (all.turnoCibo != '' ? '\nTurno Cibo: ${all.turnoCibo}' : '')),
                    trailing: Icon(
                      Icons.remove_circle,
                      color: Colors.redAccent,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
