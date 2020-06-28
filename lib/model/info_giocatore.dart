import 'package:cloud_firestore/cloud_firestore.dart';

class InfoGiocatore {
  String nome;
  String cognome;
  String displayName;
  DateTime scadenzaCertificato;

  InfoGiocatore({
    this.nome,
    this.cognome,
    this.displayName,
    this.scadenzaCertificato,
  });

  static InfoGiocatore fromSnapshot(Map<String, dynamic> snapshot) {
    return InfoGiocatore(
        nome: snapshot['nome'],
        cognome: snapshot['cognome'],
        displayName: snapshot['displayName'],
        scadenzaCertificato: snapshot['scadenzaCertificato']?.toDate());
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'cognome': cognome,
        'displayName': displayName,
        'scadenzaCertificato': scadenzaCertificato,
      };

  @override
  String toString() {
    return '$nome $cognome ($displayName)';
  }

  @override
  bool operator ==(i) => i is InfoGiocatore && i.toString() == this.toString();

  @override
  int get hashCode => super.hashCode;
}
