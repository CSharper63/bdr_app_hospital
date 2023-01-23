class Operation {
  int id;
  int dureeConvalescence;
  int dureeEnHeure;
  int idTypeOperation;
  int salleOperation;
  String nomPosteChirurgien;
  int idChirurgien;
  DateTime date;
  int idPatient;
  String description;

  Operation({
    required this.id,
    required this.dureeConvalescence,
    required this.dureeEnHeure,
    required this.idTypeOperation,
    required this.salleOperation,
    required this.nomPosteChirurgien,
    required this.idChirurgien,
    required this.date,
    required this.idPatient,
    required this.description,
  });
}
