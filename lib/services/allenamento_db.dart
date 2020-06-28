import 'package:alley_app/model/allenamento.dart';
import 'package:alley_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllenamentoDbService {
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final CollectionReference teamsCollection = Firestore.instance.collection('teams');
  final CollectionReference practiceCollection = Firestore.instance.collection('practices');

  User _currentUser;

  User get currentUser => _currentUser;

  Future<String> getIdSquadra(String uid) async {
    return await usersCollection.document(uid).get().then((doc) => doc['idSquadra']);
  }

  Future removePractice(String id) async {
    return await practiceCollection.document(id).delete();
  }

  Stream<List<Allenamento>> getPractices(String idSquadra) {
    var res = practiceCollection.where('idSquadra', isEqualTo: idSquadra).snapshots().map(_practicesFromSnapshot);
    return res;
  }

  Future updatePractice(Allenamento a) async {
    if (a.uid != '') {
      return await practiceCollection.document(a.uid).setData(a.toJson());
    } else {
      return await practiceCollection.document().setData(a.toJson());
    }
  }

  List<Allenamento> _practicesFromSnapshot(QuerySnapshot snap) {
    List<Allenamento> res = [];
    snap.documents.forEach((i) => res.add(Allenamento.fromJson(i.documentID, i.data)));
    return res;
  }
}
