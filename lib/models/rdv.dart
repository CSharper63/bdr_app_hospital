import 'package:bdr_hospital_app/models/employe.dart';

class Rdv {
  int id;
  DateTime date;
  String prenomPatient;
  String nomPatient;
  int idPatient;
  int idMedecin;
  Employe employe;

  Rdv(
      {required this.id,
      required this.date,
      required this.prenomPatient,
      required this.nomPatient,
      required this.idPatient,
      required this.idMedecin,
      required this.employe});
}
