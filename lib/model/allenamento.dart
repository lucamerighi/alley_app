import 'package:alley_app/model/evento.dart';
import 'package:alley_app/model/user.dart';

class Allenamento extends Evento {
  String idSquadra;
  List<String> turnoCibo;

  Allenamento({uid, dataEOra, luogo, this.idSquadra = '', List<String> turnoCibo})
      : turnoCibo = turnoCibo ?? [],
        super(uid: uid, dataEOra: dataEOra, luogo: luogo);

  String get getId => uid;

  String get getLuogo => luogo;

  set setLuogo(String luogo) => this.luogo = luogo;

  String get getIdSquadra => idSquadra;

  set setIdSquadra(String idSquadra) => this.idSquadra = idSquadra;

  List<String> get getTurnoCibo => turnoCibo;

  set setTurnoCibo(List<String> turnoCibo) => this.turnoCibo = turnoCibo;

  DateTime get getDataEOra => dataEOra;

  set setDataEOra(DateTime dataEOra) => this.dataEOra = dataEOra;

  @override
  bool isMyTurnoCibo(User u) => turnoCibo.contains(u.displayName);

  @override
  String toString() {
    return '$dataEOra $luogo $idSquadra $turnoCibo';
  }

  static Allenamento fromJson(String uid, Map<String, dynamic> json) {
    print('Data e ora: ${json["dataEOra"].toDate()}');
    List<String> turni = [];
    if (json['turnoCibo'] != null) {
      json['turnoCibo'].forEach((t) => turni.add(t));
    }
    return Allenamento(
      uid: uid,
      dataEOra: json['dataEOra']?.toDate(),
      idSquadra: json['idSquadra'],
      luogo: json['luogo'],
      turnoCibo: turni,
    );
  }

  Map<String, dynamic> toJson() => {
        'dataEOra': dataEOra,
        'idSquadra': idSquadra,
        'luogo': luogo,
        'turnoCibo': turnoCibo,
      };
}
