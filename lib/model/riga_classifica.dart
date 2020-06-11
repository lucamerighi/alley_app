class RigaClassifica {
  int posizione;
  String nome;
  int punti;
  int vinte;
  int perse;

  RigaClassifica(this.posizione, this.nome, this.punti, this.vinte, this.perse);

  int get getPosizione => posizione;

  set setPosizione(int posizione) => this.posizione = posizione;

  String get getNome => nome;

  set setNome(String nome) => this.nome = nome;

  int get getPunti => punti;

  set setPunti(int punti) => this.punti = punti;

  int get getVinte => vinte;

  set setVinte(int vinte) => this.vinte = vinte;

  int get getPerse => perse;

  set setPerse(int perse) => this.perse = perse;
}
