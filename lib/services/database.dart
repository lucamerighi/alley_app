import 'package:alley_app/model/data.dart';
import 'package:alley_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference usersCollection = Firestore.instance.collection('users');

  Future<User> getUser(String uid) async {
    return User.fromSnapshot(await usersCollection.document(uid).get());
  }

  Future saveUser(String uid, String email, String nome, String cognome, String displayName, Ruolo ruolo) async {
    return await usersCollection.document(uid).setData(
        {'email': email, 'nome': nome, 'cognome': cognome, 'displayName': displayName, 'ruolo': ruolo.toString()});
  }
}
