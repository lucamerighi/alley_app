import 'package:alley_app/model/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistraSquadraDbService {
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final CollectionReference teamsCollection = Firestore.instance.collection('teams');

  Future<bool> registerTeam(String idSquadra, String regione, String nome, String girone, Sesso sesso,
      String campionato, String coachId) async {
    if (await this.teamAlreadySigned(idSquadra)) {
      return false;
    } else {
      await usersCollection.document(coachId).updateData({'idSquadra': idSquadra});
      await teamsCollection.document().setData({
        'idSquadra': idSquadra,
        'regione': regione,
        'nome': nome,
        'girone': girone,
        'sesso': sesso.toString().split('.')[1],
        'campionato': campionato,
      });
      return true;
    }
  }

  Future<bool> teamAlreadySigned(String idSquadra) async {
    var docs = await teamsCollection.where('idSquadra', isEqualTo: idSquadra).getDocuments();
    return docs.documents.length != 0;
  }
}
