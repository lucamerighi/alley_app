import 'package:alley_app/model/info_giocatore.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/views/squadra/aggiungi_giocatore.dart';
import 'package:flutter/material.dart';

class ViewGiocatori extends StatefulWidget {
  @override
  _ViewGiocatoriState createState() => _ViewGiocatoriState();
}

class _ViewGiocatoriState extends State<ViewGiocatori> {
  DatabaseService dbService = getIt<DatabaseService>();

  void _showDialog(InfoGiocatore info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Rimozione giocatore"),
          content: Text(Sei sicuro di voler rimuovere ${info.nome} ${info.cognome} dalla squadra?),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('Sì'),
              onPressed: () {
                dbService.removePlayer(info);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showAddPlayer() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: AggiungiGiocatoreForm(),
              color: Colors.grey[700],
            );
          });
    }

    return StreamBuilder<List<InfoGiocatore>>(
        stream: dbService.getTeamMembersInfoStream(dbService.currentUser.idSquadra),
        builder: (context, snapshot) {
          List<InfoGiocatore> infoGiocatori = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("Elenco Giocatori: "),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Colors.grey[700],
                    ),
                    itemCount: infoGiocatori?.length ?? 0,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ListTile(
                        title: Text(infoGiocatori[index].toString()),
                        trailing: GestureDetector(
                          onTap: () => _showDialog(infoGiocatori[index]),
                          child: Icon(
                            Icons.remove_circle,
                            color: Colors.redAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () => _showAddPlayer(),
                    child: Text('Aggiungi Giocatore'),
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
