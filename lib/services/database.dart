import 'package:alley_app/model/data.dart';
import 'package:alley_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference usersCollection = Firestore.instance.collection('users');

  Future<User> get user async {
    return User.fromSnapshot(await usersCollection.document(uid).get());
  }

  Future saveUser(String email, String nome, String cognome, String displayName, Ruolo ruolo) async {
    return await usersCollection.document(uid).setData(
        {'email': email, 'nome': nome, 'cognome': cognome, 'displayName': displayName, 'ruolo': ruolo.toString()});
  }
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents
  //       .map((doc) =>
  //           Brew(name: doc.data['name'] ?? '', sugars: doc.data['sugars'] ?? '0', strength: doc.data['strength'] ?? 0))
  //       .toList();
  // }

  // Stream<List<Brew>> get brews {
  //   return usersCollection.snapshots().map(_brewListFromSnapshot);
  // }

  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid, name: snapshot.data['name'], sugars: snapshot.data['sugars'], strength: snapshot.data['strength']);
  // }

  // Stream<UserData> get userData {
  //   return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  // }
}
