import 'package:alley_app/model/data.dart';
import 'package:alley_app/model/partita.dart';
import 'package:alley_app/model/user.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/partite_db.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:alley_app/views/informazioni/show_convocazione.dart';
import 'package:alley_app/views/squadra/edit_convocazione.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd/MM/yy HH:mm');

class ViewPartiteFuture extends StatefulWidget {
  @override
  _ViewPartiteFutureState createState() => _ViewPartiteFutureState();
}

class _ViewPartiteFutureState extends State<ViewPartiteFuture> {
  final PartiteDbService partiteDb = getIt<PartiteDbService>();
  final User user = getIt<DatabaseService>().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleziona partita: "),
      ),
      body: FutureBuilder(
        future: partiteDb.getPartiteFuture(user.idSquadra),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Partita> partite = snapshot.data;
            return Container(
              child: ListView.builder(
                itemCount: partite?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Partita p = partite[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Column(
                          children: <Widget>[
                            Text(
                              '${p.casa.nome}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${p.ospite.nome}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Center(child: Text(formatter.format(p.dataEOra))),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            String casaOspite = p.casa.idSquadra == user.idSquadra ? 'casa' : 'ospite';
                            return user.ruolo == Ruolo.Coach
                                ? EditConvocazione(partita: p, casaOspite: casaOspite)
                                : ShowConvocazione(
                                    convocati: casaOspite == 'casa' ? p.casa.convocazioni : p.ospite.convocazioni);
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
