import 'package:flutter/cupertino.dart';

class Allenamento {
  String id;
  DateTime dataEORa;
  String luogo;
  String idSquadra;
  String turnoCibo;

  Allenamento({this.id = '', DateTime dataEORa, this.luogo = '', this.idSquadra = '', this.turnoCibo = ''})
      : dataEORa = dataEORa ?? DateTime.now();

  String get getId => id;

  String get getLuogo => luogo;

  set setLuogo(String luogo) => this.luogo = luogo;

  String get getIdSquadra => idSquadra;

  set setIdSquadra(String idSquadra) => this.idSquadra = idSquadra;

  String get getTurnoCibo => turnoCibo;

  set setTurnoCibo(String turnoCibo) => this.turnoCibo = turnoCibo;

  DateTime get getDataEOra => dataEORa;

  set setDataEOra(DateTime dataEOra) => this.dataEORa = dataEOra;

  @override
  String toString() {
    return '$dataEORa $luogo $idSquadra $turnoCibo';
  }

  static Allenamento fromJson(String uid, Map<String, dynamic> json) {
    print('Data e ora: ${json["dataEOra"].toDate()}');
    return Allenamento(
        id: uid,
        dataEORa: json['dataEOra']?.toDate(),
        idSquadra: json['idSquadra'],
        luogo: json['luogo'],
        turnoCibo: json['turnoCibo']);
  }

  Map<String, dynamic> toJson() => {
        'dataEOra': dataEORa,
        'idSquadra': idSquadra,
        'luogo': luogo,
        'turnoCibo': turnoCibo,
      };
}
