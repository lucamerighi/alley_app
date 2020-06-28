import 'package:alley_app/model/allenamento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllenamentoDbService {
  final CollectionReference practiceCollection = Firestore.instance.collection('practices');

  Future removePractice(String id) async {
    return await practiceCollection.document(id).delete();
  }

  Future<List<Allenamento>> getPracticesList(String idSquadra) async {
    return _practicesFromSnapshot(await practiceCollection.where('idSquadra', isEqualTo: idSquadra).getDocuments());
  }

  Stream<List<Allenamento>> getPracticesStream(String idSquadra) {
    var res = practiceCollection.where('idSquadra', isEqualTo: idSquadra).snapshots().map(_practicesFromSnapshot);
    return res;
  }

  List<Allenamento> _practicesFromSnapshot(QuerySnapshot snap) {
    List<Allenamento> res = [];
    snap.documents.forEach((i) => res.add(Allenamento.fromJson(i.documentID, i.data)));
    return res;
  }

  Future updatePractice(Allenamento a) async {
    if (a.uid != '') {
      // New practice to add
      return await practiceCollection.document(a.uid).setData(a.toJson());
    } else {
      // Already existing practice to edit
      return await practiceCollection.document().setData(a.toJson());
    }
  }
}
