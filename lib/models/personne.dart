class Personne {
  int id;
  String nom;
  String prenom;
  DateTime dateDeNaissance;
  String npa;
  String pays;
  String ville;
  String rue;
  String numero;

  Personne(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.dateDeNaissance,
      required this.npa,
      required this.pays,
      required this.ville,
      required this.rue,
      required this.numero});

  factory Personne.fromPostgre(dynamic row) {
    return Personne(
      id: row[0],
      nom: row[1],
      prenom: row[2],
      dateDeNaissance: row[3],
      ville: row[4],
      numero: row[5],
      npa: row[6],
      rue: row[7],
      pays: row[8],
    );
  }
}
