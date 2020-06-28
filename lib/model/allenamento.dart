import 'package:alley_app/model/evento.dart';

class Allenamento extends Evento {
  String idSquadra;
  String turnoCibo;

  Allenamento({uid, dataEOra, luogo, this.idSquadra = '', this.turnoCibo = ''})
      : super(uid: uid, dataEOra: dataEOra, luogo: luogo);

  String get getId => uid;

  String get getLuogo => luogo;

  set setLuogo(String luogo) => this.luogo = luogo;

  String get getIdSquadra => idSquadra;

  set setIdSquadra(String idSquadra) => this.idSquadra = idSquadra;

  String get getTurnoCibo => turnoCibo;

  set setTurnoCibo(String turnoCibo) => this.turnoCibo = turnoCibo;

  DateTime get getDataEOra => dataEOra;

  set setDataEOra(DateTime dataEOra) => this.dataEOra = dataEOra;

  @override
  String toString() {
    return '$dataEOra $luogo $idSquadra $turnoCibo';
  }

  static Allenamento fromJson(String uid, Map<String, dynamic> json) {
    print('Data e ora: ${json["dataEOra"].toDate()}');
    return Allenamento(
        uid: uid,
        dataEOra: json['dataEOra']?.toDate(),
        idSquadra: json['idSquadra'],
        luogo: json['luogo'],
        turnoCibo: json['turnoCibo']);
  }

  Map<String, dynamic> toJson() => {
        'dataEOra': dataEOra,
        'idSquadra': idSquadra,
        'luogo': luogo,
        'turnoCibo': turnoCibo,
      };
}
