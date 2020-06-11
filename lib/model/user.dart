import 'package:alley_app/model/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String nome;
  final String cognome;
  final String displayName;
  final Ruolo ruolo;
  String idSquadra;
  DateTime scadenzaCertificato;

  User(
      {this.uid,
      this.ruolo,
      this.email,
      this.nome,
      this.cognome,
      this.displayName,
      this.idSquadra,
      this.scadenzaCertificato});

  static User fromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: snapshot.documentID,
        email: snapshot['email'],
        nome: snapshot['nome'],
        cognome: snapshot['cognome'],
        displayName: snapshot['displayName'],
        ruolo: Ruolo.values.firstWhere((r) => r.toString() == snapshot['ruolo']),
        idSquadra: snapshot['idSquadra'],
        scadenzaCertificato: snapshot['scadenzaCertificato']);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'nome': nome,
        'cognome': cognome,
        'displayname': displayName,
        'ruolo': ruolo,
        'idSquadra': idSquadra,
        'scadenzaCertificato': scadenzaCertificato
      };

  @override
  String toString() {
    return '$nome $cognome, $ruolo $scadenzaCertificato';
  }
}

//  uid = snapshot.documentID,
//   email = snapshot['email'],
//   nome = snapshot['nome'],
//   cognome = snapshot['cognome'],
//   displayName = snapshot['displayName'],
//   ruolo = snapshot['ruolo'],
//   idSquadra = snapshot['idSquadra'],
//   scadenzaCertificato = snapshot['scadenzaCertificato'];
