import 'package:alley_app/model/info_giocatore.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd/MM/yy');

class ViewCertificati extends StatelessWidget {
  final DatabaseService dbService = getIt<DatabaseService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<InfoGiocatore>>(
        stream: dbService.getTeamMembersInfoStream(dbService.currentUser.idSquadra),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<InfoGiocatore> players = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Certificati: '),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      InfoGiocatore info = players[index];
                      bool scaduto =
                          info.scadenzaCertificato == null || info.scadenzaCertificato.isBefore(DateTime.now());
                      String dataDisplay =
                          info.scadenzaCertificato != null ? formatter.format(info.scadenzaCertificato) : 'Assente';
                      return Container(
                        height: 50,
                        child: Card(
                          color: scaduto ? Colors.red : Colors.green,
                          child: Center(
                              child: Text(
                            '${info.toString()} - $dataDisplay',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
                    },
                    itemCount: players.length),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
