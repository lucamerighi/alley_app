import 'package:alley_app/model/data.dart';
import 'package:alley_app/model/info_giocatore.dart';
import 'package:alley_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
  final CollectionReference teamsCollection =
      Firestore.instance.collection('teams');

  User _currentUser;

  User get currentUser => _currentUser;

  Future<User> getUser(String uid) async {
    _currentUser = User.fromSnapshot(await usersCollection.document(uid).get());
    return _currentUser;
  }

  Future saveUser(String uid, String email, String nome, String cognome,
      String displayName, Ruolo ruolo) async {
    return await usersCollection.document(uid).setData({
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'displayName': displayName,
      'ruolo': ruolo.toString(),
    });
  }

  Future<String> getIdSquadra(String uid) async {
    return await usersCollection
        .document(uid)
        .get()
        .then((doc) => doc['idSquadra']);
  }

  Future updateCertificato(DateTime scadenza) async {
    await usersCollection
        .document(currentUser.uid)
        .updateData({'scadenzaCertificato': scadenza});
    InfoGiocatore infoGiocatore = InfoGiocatore(
        nome: currentUser.nome,
        cognome: currentUser.cognome,
        displayName: currentUser.displayName,
        scadenzaCertificato: currentUser.scadenzaCertificato);

    currentUser.scadenzaCertificato = scadenza;

    var val = [];
    val.add(infoGiocatore.toJson());
    var docs = await teamsCollection
        .where('idSquadra', isEqualTo: currentUser.idSquadra)
        .getDocuments();
    var doc = docs.documents.single.reference;
    doc.updateData({"infoGiocatori": FieldValue.arrayRemove(val)});

    val = [];
    infoGiocatore.scadenzaCertificato = scadenza;
    val.add(infoGiocatore.toJson());
    doc.updateData({"infoGiocatori": FieldValue.arrayUnion(val)});
  }
}
