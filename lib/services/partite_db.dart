import 'package:alley_app/model/partita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class PartiteDb {
  final gamesCollection = Firestore.instance.collection('games');

  Stream<List<Partita>> getPartite(String idSquadra) {
    var stream1 = gamesCollection.where('casa.idSquadra', isEqualTo: idSquadra).snapshots().map(_partiteFromSnapshot);
    var stream2 = gamesCollection.where('ospite.idSquadra', isEqualTo: idSquadra).snapshots().map(_partiteFromSnapshot);
    return MergeStream([stream1, stream2]);
  }

  List<Partita> _partiteFromSnapshot(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      Map<String, dynamic> data = doc.data;
      SquadraPartecipante casa = _buildSquadra(data['casa']);
      SquadraPartecipante ospite = _buildSquadra(data['ospite']);
      return Partita(
        uid: doc.documentID,
        dataEOra: data['dataEOra'].toDate(),
        luogo: data['luogo'],
        casa: casa,
        ospite: ospite,
      );
    }).toList();
  }

  SquadraPartecipante _buildSquadra(Map<String, dynamic> squadra) {
    List<Convocazione> conv = [];
    squadra['convocazioni'].forEach((c) => conv.add(Convocazione.fromJson(c)));
    return SquadraPartecipante(
      idSquadra: squadra['idSquadra'],
      nome: squadra['nome'],
      punti: squadra['punti'] ?? 0,
      turnoCibo: squadra['turnoCibo'] ?? '',
      convocazioni: conv,
    );
  }
}
