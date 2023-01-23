class Rdv {
  int id;
  DateTime date;
  String prenomPatient;
  String nomPatient;
  int idPatient;
  int idMedecin;

  Rdv(
      {required this.id,
      required this.date,
      required this.prenomPatient,
      required this.nomPatient,
      required this.idPatient,
      required this.idMedecin});
}
