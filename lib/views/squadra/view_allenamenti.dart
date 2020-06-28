import 'package:alley_app/model/allenamento.dart';
import 'package:alley_app/services/allenamento_db.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd/MM/yy HH:mm');

class ViewAllenamenti extends StatefulWidget {
  @override
  _ViewAllenamentiState createState() => _ViewAllenamentiState();
}

class _ViewAllenamentiState extends State<ViewAllenamenti> {
  List<Allenamento> allenamenti = [];
  AllenamentoDbService allenamentoDbService = getIt<AllenamentoDbService>();
  DatabaseService dbService = getIt<DatabaseService>();
  bool loading = false;

  void _editDateTime(Allenamento a) {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: a.dataEORa.add(Duration(days: 365)), onConfirm: (date) {
      if (allenamenti != null && allenamenti.contains(a)) {
        setState(() {
          if (allenamenti != null) allenamenti.firstWhere((all) => all.id == a.id).dataEORa = date;
        });
      } else {
        a.dataEORa = date;
      }
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
                    Text(a.dataEORa != null ? formatter.format(a.dataEORa) : 'Data e ora'),
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
                      onPressed: () async {
                        setState(() => loading = true);
                        dynamic result = await allenamentoDbService.removePractice(a.id);
                        if (result == null) {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      color: Colors.redAccent,
                      child: Text('Elimina'),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        setState(() => loading = true);
                        a.idSquadra = dbService.currentUser.idSquadra;
                        a.luogo = _controller.text;
                        dynamic result = await allenamentoDbService.updatePractice(a);
                        if (result == null) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                        }
                      },
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
    return StreamBuilder<List<Allenamento>>(
        stream: allenamentoDbService.getPractices(dbService.currentUser.idSquadra),
        builder: (context, snapshot) {
          allenamenti = snapshot.data;
          print('Allenamenti: $allenamenti');
          return Scaffold(
            appBar: AppBar(title: Text('Allenamenti')),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Colors.grey[700],
                    ),
                    itemCount: allenamenti != null ? allenamenti.length : 0,
                    itemBuilder: (BuildContext ctx, int index) {
                      Allenamento all = allenamenti[index];
                      return InkWell(
                        onTap: () => _showEditAllenamento(all),
                        child: ListTile(
                          title: Text(
                              all.dataEORa != null ? formatter.format(all.dataEORa) : 'Data e ora non specificate'),
                          subtitle: Text(all.luogo + (all.turnoCibo != null ? '\nTurno Cibo: ${all.turnoCibo}' : '')),
                          trailing: Icon(Icons.keyboard_arrow_right),
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
        });
  }
}
