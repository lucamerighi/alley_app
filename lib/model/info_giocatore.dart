class InfoGiocatore {
  String nome;
  String cognome;
  String displayName;
  DateTime scadenzaCertificato;

  InfoGiocatore({
    this.nome,
    this.cognome,
    this.displayName,
    this.scadenzaCertificato,
  });

  static InfoGiocatore fromJson(Map<String, dynamic> json) {
    return InfoGiocatore(
        nome: json['nome'],
        cognome: json['cognome'],
        displayName: json['displayName'],
        scadenzaCertificato: json['scadenzaCertificato']?.toDate());
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'cognome': cognome,
        'displayName': displayName,
        'scadenzaCertificato': scadenzaCertificato,
      };

  @override
  String toString() {
    return '$nome $cognome ($displayName)';
  }

  @override
  bool operator ==(i) => i is InfoGiocatore && i.toString() == this.toString();

  @override
  int get hashCode => super.hashCode;
}
