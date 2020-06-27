import 'package:alley_app/model/data.dart';
import 'package:alley_app/model/info_giocatore.dart';
import 'package:alley_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final CollectionReference teamsCollection = Firestore.instance.collection('teams');

  User _currentUser;

  User get currentUser => _currentUser;

  Future<User> getUser(String uid) async {
    _currentUser = User.fromSnapshot(await usersCollection.document(uid).get());
    return _currentUser;
  }

  Future<User> getUserByEmail(String email) {
    return usersCollection
        .where('email', isEqualTo: email)
        .getDocuments()
        .then((value) => User.fromSnapshot(value.documents.single));
  }

  Future saveUser(String uid, String email, String nome, String cognome, String displayName, Ruolo ruolo) async {
    return await usersCollection.document(uid).setData({
      'email': email,
      'nome': nome,
      'cognome': cognome,
      'displayName': displayName,
      'ruolo': ruolo.toString(),
    });
  }

  Future<String> getIdSquadra(String uid) async {
    return await usersCollection.document(uid).get().then((doc) => doc['idSquadra']);
  }

  Stream<List<InfoGiocatore>> getTeamMembers(String idSquadra) {
    var res = teamsCollection.where('idSquadra', isEqualTo: idSquadra).snapshots().map(_playerInfoFromSnapshot);
    return res;
  }

  List<InfoGiocatore> _playerInfoFromSnapshot(QuerySnapshot snap) {
    DocumentSnapshot doc = snap.documents[0];
    List<Object> info = doc.data['infoGiocatori'];
    List<InfoGiocatore> res = [];
    info.forEach((i) => res.add(InfoGiocatore.fromSnapshot(i)));
    return res;
  }

  Future updateCertificato(DateTime scadenza) async {
    await usersCollection.document(currentUser.uid).updateData({'scadenzaCertificato': scadenza});
    InfoGiocatore infoGiocatore = InfoGiocatore(
        nome: currentUser.nome,
        cognome: currentUser.cognome,
        displayName: currentUser.displayName,
        scadenzaCertificato: currentUser.scadenzaCertificato);

    currentUser.scadenzaCertificato = scadenza;

    var val = [];
    val.add(infoGiocatore.toJson());
    var docs = await teamsCollection.where('idSquadra', isEqualTo: currentUser.idSquadra).getDocuments();
    var doc = docs.documents.single.reference;
    doc.updateData({"infoGiocatori": FieldValue.arrayRemove(val)});

    val = [];
    infoGiocatore.scadenzaCertificato = scadenza;
    val.add(infoGiocatore.toJson());
    doc.updateData({"infoGiocatori": FieldValue.arrayUnion(val)});
  }

  void removePlayer(InfoGiocatore info) async {
    var docs = await teamsCollection.where('idSquadra', isEqualTo: currentUser.idSquadra).getDocuments();
    var doc = docs.documents.single.reference;
    print('rimuovo ${info.displayName}');
    doc.updateData({
      'infoGiocatori': FieldValue.arrayRemove([info.toJson()])
    });
    docs = await usersCollection.where('displayName', isEqualTo: info.displayName).getDocuments();
    doc = docs.documents.single.reference;
    doc.updateData({'idSquadra': null});
  }

  void addPlayer(String email) async {
    User u = await getUserByEmail(email);
    var docs = await teamsCollection.where('idSquadra', isEqualTo: currentUser.idSquadra).getDocuments();
    var doc = docs.documents.single.reference;
    print('aggiungo $email');
    doc.updateData({
      'infoGiocatori': FieldValue.arrayUnion([
        {
          'nome': u.nome,
          'cognome': u.cognome,
          'displayName': u.displayName,
          'scadenzaCertificato': u.scadenzaCertificato
        }
      ])
    });
    usersCollection.document(u.uid).updateData({'idSquadra': currentUser.idSquadra});
  }
}
