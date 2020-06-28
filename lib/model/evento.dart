class Evento {
  String uid;
  DateTime dataEOra;
  String luogo;

  Evento({this.uid = '', DateTime dataEOra, this.luogo}) : dataEOra = dataEOra ?? DateTime.now();

  @override
  bool operator ==(e) => e is Evento && e.uid == uid;

  @override
  int get hashCode => super.hashCode;
}
