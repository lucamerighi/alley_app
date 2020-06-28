import 'package:alley_app/model/evento.dart';
import 'package:alley_app/model/info_giocatore.dart';

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
    List<Convocazione> conv = [];
    json['convocazioni'].forEach((c) => conv.add(Convocazione.fromJson(c)));
    return SquadraPartecipante(
      idSquadra: json['idSquadra'],
      nome: json['nome'],
      punti: json['punti'] ?? 0,
      turnoCibo: json['turnoCibo'] ?? '',
      convocazioni: conv,
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

  Map<String, dynamic> toJson() => {
        'cognome': cognome,
        'nome': nome,
        'displayName': displayName,
      };

  static Convocazione fromInfo(InfoGiocatore info) {
    return Convocazione(cognome: info.cognome, nome: info.nome, displayName: info.displayName);
  }

  @override
  String toString() {
    return '$nome $cognome ($displayName)';
  }

  @override
  bool operator ==(c) => c.toString() == this.toString();

  @override
  int get hashCode => super.hashCode;
}
