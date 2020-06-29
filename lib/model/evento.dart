import 'package:alley_app/model/user.dart';

class Evento {
  String uid;
  DateTime dataEOra;
  String luogo;

  Evento({this.uid = '', DateTime dataEOra, this.luogo}) : dataEOra = dataEOra ?? DateTime.now();

  DateTime get day => DateTime(dataEOra.year, dataEOra.month, dataEOra.day);

  bool isMyTurnoCibo(User u) => null;

  @override
  bool operator ==(e) => e is Evento && e.uid == uid;

  @override
  int get hashCode => super.hashCode;
}
