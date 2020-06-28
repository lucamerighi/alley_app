import 'package:alley_app/model/info_giocatore.dart';

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
