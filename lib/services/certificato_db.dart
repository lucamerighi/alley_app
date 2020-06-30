import 'package:alley_app/model/info_giocatore.dart';
import 'package:alley_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CertificatoDbService {
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final CollectionReference teamsCollection = Firestore.instance.collection('teams');

  updateCertificato(DateTime scadenza, User u) async {
    await usersCollection.document(u.uid).updateData({'scadenzaCertificato': scadenza});
    InfoGiocatore infoGiocatore = InfoGiocatore(
        nome: u.nome, cognome: u.cognome, displayName: u.displayName, scadenzaCertificato: u.scadenzaCertificato);

    u.scadenzaCertificato = scadenza;

    var val = [];
    val.add(infoGiocatore.toJson());
    var docs = await teamsCollection.where('idSquadra', isEqualTo: u.idSquadra).getDocuments();
    var doc = docs.documents.single.reference;
    doc.updateData({"infoGiocatori": FieldValue.arrayRemove(val)});

    val = [];
    infoGiocatore.scadenzaCertificato = scadenza;
    val.add(infoGiocatore.toJson());
    doc.updateData({"infoGiocatori": FieldValue.arrayUnion(val)});
  }
}
