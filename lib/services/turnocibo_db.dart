import 'package:alley_app/model/allenamento.dart';
import 'package:alley_app/model/evento.dart';
import 'package:alley_app/model/partita.dart';
import 'package:alley_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TurnoCiboDbService {
  final CollectionReference practiceCollection = Firestore.instance.collection('practices');
  final CollectionReference gamesCollection = Firestore.instance.collection('games');

  Future insertTurnoCibo(User user, Evento e) async {
    if (e is Partita) {
      String casaOspite = e.casa.idSquadra == user.idSquadra ? "casa" : "ospite";
      gamesCollection.document(e.uid).updateData({
        '$casaOspite.turnoCibo': FieldValue.arrayUnion([user.displayName])
      });
      casaOspite == 'casa' ? e.casa.turnoCibo.add(user.displayName) : e.ospite.turnoCibo.add(user.displayName);
    } else {
      practiceCollection.document(e.uid).updateData({
        'turnoCibo': FieldValue.arrayUnion([user.displayName])
      });
      (e as Allenamento).turnoCibo.add(user.displayName);
    }
  }

  Future removeTurnoCibo(User user, Evento e) async {
    if (e is Partita) {
      String casaOspite = e.casa.idSquadra == user.idSquadra ? "casa" : "ospite";
      gamesCollection.document(e.uid).updateData({
        '$casaOspite.turnoCibo': FieldValue.arrayRemove([user.displayName])
      });
      casaOspite == 'casa' ? e.casa.turnoCibo.remove(user.displayName) : e.ospite.turnoCibo.remove(user.displayName);
    } else {
      practiceCollection.document(e.uid).updateData({
        'turnoCibo': FieldValue.arrayRemove([user.displayName])
      });
      (e as Allenamento).turnoCibo.remove(user.displayName);
    }
  }
}
