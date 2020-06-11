import 'package:alley_app/shared/tile.dart';
import 'package:alley_app/views/squadra/registra_squadra.dart';
import 'package:alley_app/views/squadra/view_allenamenti.dart';
import 'package:alley_app/views/squadra/view_convocazioni.dart';
import 'package:alley_app/views/squadra/view_giocatori.dart';
import 'package:flutter/material.dart';

var tiles = [
  ['assets/registra_squadra.png', 'Registra Squadra', ViewRegistraSquadra()],
  ['assets/players.png', 'Giocatori', ViewGiocatori()],
  ['assets/convocazione.png', 'Convocazioni', ViewConvocazioni()],
  ['assets/training.png', 'Allenamenti', ViewAllenamenti()],
];

class HomeSquadra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Squadra')),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        children: tiles
            .map((t) => Tile(
                  imageUrl: t[0],
                  text: t[1],
                  target: t[2],
                ))
            .toList(),
      ),
    );
  }
}
