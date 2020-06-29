import 'package:alley_app/model/convocazione.dart';

class SquadraPartecipante {
  String idSquadra;
  String nome;
  int punti;
  List<String> turnoCibo;
  List<Convocazione> convocazioni;

  SquadraPartecipante({this.idSquadra, this.nome, this.punti, this.turnoCibo, this.convocazioni});

  static SquadraPartecipante fromJson(Map<String, dynamic> json) {
    List<Convocazione> conv = [];
    List<String> turni = [];

    json['convocazioni']?.forEach((c) => conv.add(Convocazione.fromJson(c)));

    json['turnoCibo']?.forEach((t) => turni.add(t));

    return SquadraPartecipante(
      idSquadra: json['idSquadra'],
      nome: json['nome'],
      punti: json['punti'] ?? 0,
      turnoCibo: turni,
      convocazioni: conv,
    );
  }
}
