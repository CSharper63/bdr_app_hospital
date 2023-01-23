import 'package:bdr_hospital_app/models/employe.dart';
import 'package:bdr_hospital_app/models/patient.dart';

class Operation {
  int id;
  int dureeConvalescence;
  int dureeEnHeure;
  int idTypeOperation;
  int salleOperation;
  String nomPosteChirurgien;
  Employe employe; // médecin opérant
  DateTime date;
  Patient patient;
  String description;

  Operation({
    required this.id,
    required this.dureeConvalescence,
    required this.dureeEnHeure,
    required this.idTypeOperation,
    required this.salleOperation,
    required this.nomPosteChirurgien,
    required this.employe,
    required this.date,
    required this.patient,
    required this.description,
  });
}
