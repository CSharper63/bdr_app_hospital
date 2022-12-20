abstract class Personne {
  String nom;
  String prenom;
  DateTime dateDeNaissance;
  String npa;
  String pays;
  String ville;
  String rue;
  String numero;

  Personne(
      {required this.nom,
      required this.prenom,
      required this.dateDeNaissance,
      required this.npa,
      required this.pays,
      required this.ville,
      required this.rue,
      required this.numero});
}
