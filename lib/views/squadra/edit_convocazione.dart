import 'package:alley_app/model/info_giocatore.dart';
import 'package:alley_app/model/partita.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/partite_db.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:flutter/material.dart';

class EditConvocazione extends StatefulWidget {
  final Partita partita;

  const EditConvocazione({Key key, this.partita}) : super(key: key);

  @override
  _EditConvocazionState createState() => _EditConvocazionState();
}

class _EditConvocazionState extends State<EditConvocazione> {
  final DatabaseService dbService = getIt<DatabaseService>();
  final PartiteDbService partiteService = getIt<PartiteDbService>();

  List<Convocazione> convocazioni;
  List<InfoGiocatore> players;

  Map<InfoGiocatore, bool> values = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    partiteService.getConvocazioniAndMembers(widget.partita.uid).then((value) {
      players = value['players'];
      convocazioni = value['convocazioni'];
      players.forEach((player) {
        values.putIfAbsent(player, () => convocazioni.contains(player));
      });
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Lista convocati: "),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      InfoGiocatore player = players[index];
                      return CheckboxListTile(
                        title: Text(player.toString()),
                        value: values[player] ?? false,
                        onChanged: (bool value) {
                          setState(() {
                            values[player] = value;
                          });
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      String uid = widget.partita.uid;
                      String casaOspite =
                          widget.partita.casa.idSquadra == dbService.currentUser.idSquadra ? 'casa' : 'ospite';
                      List<Convocazione> convocazioni = [];
                      values.keys.forEach((info) {
                        if (values[info]) convocazioni.add(Convocazione.fromInfo(info));
                      });
                      partiteService.updateConvocazioni(uid, casaOspite, convocazioni);
                    },
                    color: Colors.orangeAccent,
                    child: Text('Conferma'),
                  ),
                ),
              ],
            ),
          );
  }
}
