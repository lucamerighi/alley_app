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
        stream: dbService.getTeamMembersInfo(dbService.currentUser.idSquadra),
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
                          onTap: () => dbService.removePlayer(infoGiocatori[index]),
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
