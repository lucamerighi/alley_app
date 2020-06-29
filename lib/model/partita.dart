import 'package:alley_app/model/evento.dart';
import 'package:alley_app/model/squadra_partecipante.dart';
import 'package:alley_app/model/user.dart';

class Partita extends Evento {
  SquadraPartecipante casa;
  SquadraPartecipante ospite;

  Partita({uid, dataEOra, luogo, this.casa, this.ospite}) : super(uid: uid, dataEOra: dataEOra, luogo: luogo);

  static Partita fromJson(Map<String, dynamic> json) {
    return Partita(
      uid: json['uid'],
      dataEOra: json['dataEOra'].toDate(),
      luogo: json['luogo'],
      casa: SquadraPartecipante.fromJson(json['casa']),
      ospite: SquadraPartecipante.fromJson(json['ospite']),
    );
  }

  List<String> getTurnoCibo(String idSquadra) {
    return casa.idSquadra == idSquadra ? casa.turnoCibo : ospite.turnoCibo;
  }

  @override
  bool isMyTurnoCibo(User u) {
    return u.idSquadra == casa.idSquadra
        ? casa.turnoCibo.contains(u.displayName)
        : ospite.turnoCibo.contains(u.displayName);
  }

  @override
  String toString() {
    return '$dataEOra a $luogo';
  }
}
