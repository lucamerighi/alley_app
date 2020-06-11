import 'package:alley_app/views/squadra/aggiungi_giocatore.dart';
import 'package:flutter/material.dart';

class ViewGiocatori extends StatefulWidget {
  @override
  _ViewGiocatoriState createState() => _ViewGiocatoriState();
}

class _ViewGiocatoriState extends State<ViewGiocatori> {
  List<String> giocatori = List.generate(20, (index) => 'Player $index)');

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
              itemCount: giocatori.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ListTile(
                  title: Text(giocatori[index]),
                  trailing: Icon(
                    Icons.remove_circle,
                    color: Colors.redAccent,
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
  }
}
