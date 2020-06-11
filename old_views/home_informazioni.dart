import 'package:alley_app/shared/tile.dart';
import 'package:alley_app/views/informazioni/view_calendario.dart';
import 'package:alley_app/views/informazioni/view_classifica.dart';
import 'package:flutter/material.dart';

var tiles = [
  ['assets/calendario.png', 'Calendario', ViewCalendario()],
  ['assets/classifica.png', 'Classifica', ViewClassifica()],
];

class HomeInformazioni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Informazioni')),
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
