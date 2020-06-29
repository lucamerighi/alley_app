import 'package:alley_app/model/convocazione.dart';

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
