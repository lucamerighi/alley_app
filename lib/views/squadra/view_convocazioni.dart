import 'package:alley_app/model/partita.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/partite_db.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:alley_app/views/squadra/edit_convocazione.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd/MM/yy HH:mm');

class ViewConvocazioni extends StatefulWidget {
  @override
  _ViewConvocazioniState createState() => _ViewConvocazioniState();
}

class _ViewConvocazioniState extends State<ViewConvocazioni> {
  final PartiteDbService partiteDb = getIt<PartiteDbService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Seleziona partita: "),
        ),
        body: FutureBuilder(
            future: partiteDb.getPartiteFuture(getIt<DatabaseService>().currentUser.idSquadra),
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
                            title: Text('${p.casa.nome} - ${p.ospite.nome}'),
                            subtitle: Text(formatter.format(p.dataEOra)),
                            onTap: () => Navigator.push(
                                context, MaterialPageRoute(builder: (context) => EditConvocazione(partita: p))),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Loading();
              }
            }));
  }
}
