import 'package:flutter/cupertino.dart';

class Allenamento {
  String id;
  DateTime dataEORa;
  String luogo;
  String idSquadra;
  String turnoCibo;

  Allenamento(this.dataEORa, this.luogo, this.idSquadra, this.turnoCibo) : id = UniqueKey().toString();

  String get getId => id;

  String get getLuogo => luogo;

  set setLuogo(String luogo) => this.luogo = luogo;

  String get getIdSquadra => idSquadra;

  set setIdSquadra(String idSquadra) => this.idSquadra = idSquadra;

  String get getTurnoCibo => turnoCibo;

  set setTurnoCibo(String turnoCibo) => this.turnoCibo = turnoCibo;

  DateTime get getDataEOra => dataEORa;

  set setDataEOra(DateTime dataEOra) => this.dataEORa = dataEOra;
}
