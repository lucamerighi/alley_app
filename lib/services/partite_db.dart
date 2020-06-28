import 'package:alley_app/model/partita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartiteDbService {
  final gamesCollection = Firestore.instance.collection('games');

  Future<List<Partita>> getPartite(String idSquadra) async {
    List<Partita> partiteCasa =
        _partiteFromSnapshot(await gamesCollection.where('casa.idSquadra', isEqualTo: idSquadra).getDocuments());
    List<Partita> partiteOspite =
        _partiteFromSnapshot(await gamesCollection.where('ospite.idSquadra', isEqualTo: idSquadra).getDocuments());
    return List.from(partiteCasa)..addAll(partiteOspite);
  }

  List<Partita> _partiteFromSnapshot(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      Map<String, dynamic> data = doc.data;
      SquadraPartecipante casa = SquadraPartecipante.fromJson(data['casa']);
      SquadraPartecipante ospite = SquadraPartecipante.fromJson(data['ospite']);
      return Partita(
        uid: doc.documentID,
        dataEOra: data['dataEOra'].toDate(),
        luogo: data['luogo'],
        casa: casa,
        ospite: ospite,
      );
    }).toList();
  }
}
