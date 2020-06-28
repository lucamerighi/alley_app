import 'package:alley_app/model/evento.dart';
import 'package:alley_app/model/squadra_partecipante.dart';

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

  @override
  String toString() {
    return '$dataEOra a $luogo';
  }
}
