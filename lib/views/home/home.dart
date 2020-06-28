import 'package:alley_app/model/data.dart';
import 'package:alley_app/model/user.dart';
import 'package:alley_app/services/auth.dart';
import 'package:alley_app/shared/loading.dart';
import 'package:alley_app/shared/tile.dart';
import 'package:alley_app/views/informazioni/view_calendario.dart';
import 'package:alley_app/views/informazioni/view_certificato.dart';
import 'package:alley_app/views/informazioni/view_classifica.dart';
import 'package:alley_app/views/squadra/registra_squadra.dart';
import 'package:alley_app/views/squadra/view_allenamenti.dart';
import 'package:alley_app/views/squadra/view_certificati.dart';
import 'package:alley_app/views/squadra/view_partite_future.dart';
import 'package:alley_app/views/squadra/view_giocatori.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Map<Ruolo, List<dynamic>> tiles = {
  Ruolo.Coach: [
    ['assets/registra_squadra.png', 'Registra Squadra', ViewRegistraSquadra()],
    ['assets/players.png', 'Giocatori', ViewGiocatori()],
    ['assets/convocazione.png', 'Convocazioni', ViewPartiteFuture()],
    ['assets/training.png', 'Allenamenti', ViewAllenamenti()],
    ['assets/calendario.png', 'Calendario', ViewCalendario()],
    ['assets/classifica.png', 'Classifica', ViewClassifica()],
    ['assets/certificato.png', 'Certificati', ViewCertificati()],
  ],
  Ruolo.Giocatore: [
    ['assets/calendario.png', 'Calendario', ViewCalendario()],
    ['assets/classifica.png', 'Classifica', ViewClassifica()],
    ['assets/certificato.png', 'Certificato', ViewCertificato()],
    ['assets/convocazione.png', 'Convocazioni', ViewPartiteFuture()],
  ]
};

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return user == null
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Alley App',
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async => await _auth.signOut())
              ],
            ),
            body: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              children: tiles[user.ruolo].map((t) => Tile(imageUrl: t[0], text: t[1], target: t[2])).toList(),
            ),
          );
  }
}
