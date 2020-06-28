import 'package:alley_app/model/evento.dart';

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

class SquadraPartecipante {
  String idSquadra;
  String nome;
  int punti;
  String turnoCibo;
  List<Convocazione> convocazioni;

  SquadraPartecipante({this.idSquadra, this.nome, this.punti, this.turnoCibo, this.convocazioni});

  static SquadraPartecipante fromJson(Map<String, dynamic> json) {
    return SquadraPartecipante(
      idSquadra: json['idSquadra'],
      nome: json['nome'],
      punti: json['displayName'],
      turnoCibo: json['turnoCibo'],
      convocazioni: json['convocazioni'].map(Convocazione.fromJson),
    );
  }
}

class Convocazione {
  String nome;
  String cognome;
  String displayName;

  Convocazione({this.nome, this.cognome, this.displayName});

  static Convocazione fromJson(Map<String, dynamic> json) {
    return Convocazione(
      nome: json['nome'] ?? '',
      cognome: json['cognome'] ?? '',
      displayName: json['displayName'] ?? '',
    );
  }
}
