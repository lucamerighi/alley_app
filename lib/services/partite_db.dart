import 'package:alley_app/model/convocazione.dart';
import 'package:alley_app/model/info_giocatore.dart';
import 'package:alley_app/model/partita.dart';
import 'package:alley_app/model/squadra_partecipante.dart';
import 'package:alley_app/services/database.dart';
import 'package:alley_app/services/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartiteDbService {
  final gamesCollection = Firestore.instance.collection('games');
  final DatabaseService dbService = getIt<DatabaseService>();

  updateConvocazioni(String uid, String casaOspite, List<Convocazione> convocazioni) {
    gamesCollection.document(uid).updateData({'$casaOspite.convocazioni': FieldValue.delete()});
    gamesCollection
        .document(uid)
        .updateData({'$casaOspite.convocazioni': FieldValue.arrayUnion(convocazioni.map((c) => c.toJson()).toList())});
  }

  Future<Map> getConvocazioniAndMembers(String uid) async {
    String idSquadra = dbService.currentUser.idSquadra;
    List<InfoGiocatore> teamMembers = await dbService.getTeamMembersInfoFuture(idSquadra);
    Partita partita = Partita.fromJson((await gamesCollection.document(uid).get()).data);
    List<Convocazione> convocazioni =
        partita.casa.idSquadra == idSquadra ? partita.casa.convocazioni : partita.ospite.convocazioni;
    return {'players': teamMembers, 'convocazioni': convocazioni};
  }

  Future<List<Partita>> getPartiteFuture(String idSquadra) async {
    List<Partita> partiteCasa = _partiteFromSnapshot(await gamesCollection
        .where('casa.idSquadra', isEqualTo: idSquadra)
        .where('dataEOra', isGreaterThanOrEqualTo: DateTime.now())
        .getDocuments());
    List<Partita> partiteOspite = _partiteFromSnapshot(await gamesCollection
        .where('ospite.idSquadra', isEqualTo: idSquadra)
        .where('dataEOra', isGreaterThanOrEqualTo: DateTime.now())
        .getDocuments());
    return List.from(partiteCasa)..addAll(partiteOspite);
  }

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
