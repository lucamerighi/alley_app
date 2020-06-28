class Evento {
  String uid;
  DateTime dataEOra;
  String luogo;

  Evento({this.uid, this.dataEOra, this.luogo});

  @override
  bool operator ==(e) => e is Evento && e.uid == uid;

  @override
  int get hashCode => super.hashCode;
}
