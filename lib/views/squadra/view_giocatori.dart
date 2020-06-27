import 'package:alley_app/services/database.dart';
import 'package:alley_app/views/squadra/aggiungi_giocatore.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewGiocatori extends StatefulWidget {
  @override
  _ViewGiocatoriState createState() => _ViewGiocatoriState();
}

class _ViewGiocatoriState extends State<ViewGiocatori> {
  DatabaseService dbService = getIt<DatabaseService>();
  List<String> giocatori;

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

    return StreamProvider<List<String>>.value(
      value: dbService.getTeamMembers(dbService.currentUser.idSquadra),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Elenco Giocatori: "),
        ),
        body: Column(
          children: <Widget>[
            Text(Provider.of<List<String>>(context)[0]),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey[700],
                ),
                itemCount: giocatori.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ListTile(
                    title: Text(giocatori[index]),
                    trailing: GestureDetector(
                      // TODO
                      onTap: () => {},
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
      ),
    );
  }
}
