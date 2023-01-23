import 'dart:developer' as dev;

import 'package:bdr_hospital_app/models/employe.dart';
import 'package:bdr_hospital_app/models/patient.dart';
import 'package:bdr_hospital_app/models/rdv.dart';
import 'package:bdr_hospital_app/services/postgres_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';

enum DbStatus { undefined, connected, unreachable }

class PostgresController extends GetxController {
  final String _searchPath = 'SET search_path TO hopital;';
  final _connection = PostgreSQLConnection(
      PostgresService.host, PostgresService.port, PostgresService.databaseName,
      username: PostgresService.username, password: PostgresService.password);

  final Rx<DbStatus> _dbStatus = Rx(DbStatus.undefined);
  final RxList<Patient> _listPatients = RxList();
  final RxList<Employe> _listEmployees = RxList();
  final RxList<Employe> _listMedecinGeneraliste = RxList();
  final RxList<Employe> _listPersoMedical = RxList();
  final RxList<Employe> _listInfirmier = RxList();
  final RxList<Employe> _listUrologue = RxList();
  final RxList<Employe> _listOncologue = RxList();
  final RxList<Employe> _listCardiologue = RxList();

  final RxList<Rdv> _listRdv = RxList();
  final RxList<List> _listAnalytics = RxList();
  final RxList<List> _listEmployesService = RxList();

  PostgreSQLConnection get db => _connection;
  DbStatus get dbStatus => _dbStatus.value;
  List<List> get listAnalytics => _listAnalytics.value;
  List<Employe> get listCardiologue => _listCardiologue.value;
  List<Employe> get listEmployees => _listEmployees.value;
  List<List> get listEmployeesService => _listEmployesService.value;
  List<Employe> get listInfirmier => _listInfirmier.value;
  List<Employe> get listMedecinGeneraliste => _listMedecinGeneraliste.value;
  List<Employe> get listOncologue => _listOncologue.value;
  List<Patient> get listPatients => _listPatients.value;

  List<Employe> get listPersoMedical => _listPersoMedical.value;
  List<Rdv> get listRdv => _listRdv.value;

  List<Employe> get listUrologue => _listUrologue.value;

  Future<bool> insertPatient(
      int noAvs,
      String nom,
      String prenom,
      DateTime dateNaissance,
      String rue,
      String numeroRue,
      String npa,
      String ville,
      String pays,
      String nomPosteMedecinTraitant,
      int idMedecinTraitant) async {
    // dev.log('try update $id, with $newdate');

    return await _connection
        .query(
      " CALL ajouter_patient($noAvs, $nom , $prenom , $dateNaissance , $rue, $numeroRue, $npa, $ville, $pays, $nomPosteMedecinTraitant, $idMedecinTraitant)",
    )
        .then((value) {
      _getListRdv();
      _getAnalytics();
      _getListPatient();
      return true;
    }).catchError((onError) {
      return false;
    });
  }

  @override
  void onInit() {
    super.onInit();

    dev.log('PostgresController onInit');
    _connection.open().then((_) {
      dev.log('Connection success');
      _dbStatus.value = DbStatus.connected;

      _setSearchPath();

      // our queries
      _getAnalytics();
      _getListPatient();
      _getListRdv();
      _getEmployeService();
      _getListEmployees();
    }).catchError((onError) {
      dev.log('Error: $onError');
      _dbStatus.value = DbStatus.unreachable;
    });

    ever(_dbStatus, (_) {
      dev.log('db status: changed');
      switch (_dbStatus.value) {
        case DbStatus.unreachable:
          Get.showSnackbar(const GetSnackBar(
            message: 'Impossible de se connecter à la base de données',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ));
          break;
        case DbStatus.connected:
          Get.showSnackbar(const GetSnackBar(
            message: 'Base de données connectée !',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ));
          break;

        default:
      }
    });
  }

  Future<bool> updateRdv(int id, String newdate) async {
    dev.log('try update $id, with $newdate');

    return await _connection
        .query(
      " CALL update_rdv($id, '$newdate')",
    )
        .then((value) {
      _getListRdv();
      _getAnalytics();
      return true;
    }).catchError((onError) {
      return false;
    });
  }

  Future<bool> deletePatient(int noAvs) async {
    dev.log('Deleting patient noAvs : $noAvs');

    return await _connection
        .query(
      " CALL delete_patient($noAvs')",
    )
        .then((value) {
      _getListRdv();
      _getListPatient();
      _getAnalytics();
      return true;
    }).catchError((onError) {
      return false;
    });
  }

  Future<List<List>> _getAnalytics() async {
    final result = await _connection.query("SELECT * FROM afficheranalytics");

    dev.log('analytics fetched: ${result.length}');

    dev.log('result: $result');
    _listAnalytics.value = result;

    return result;
  }

  Future<List<List>> _getEmployeService() async {
    final result = await _connection.query(" SELECT * FROM afficherEmployeService");
    dev.log('services fetched: ${result.length}');
    _listEmployesService.value = result;
    return result;
  }

  Future<List<Employe>> _getListEmployees() async {
    final result = await _connection.query("SELECT * FROM afficheremployes");

    final result2 = List.generate(result.length, (i) {
      return Employe(
          nomService: result[i][10],
          nomPoste: result[i][11],
          prenom: result[i][3],
          nom: result[i][2],
          noAvs: result[i][0],
          dateDeNaissance: result[i][4],
          pourcentageTravail: result[i][1]);
    });
    _listEmployees.value = result2;
    _listPersoMedical.value = _listEmployees.where((e) => e.nomService != 'Reception').toList();
    _listMedecinGeneraliste.value =
        _listEmployees.where((e) => e.nomPoste == 'Medecin generaliste').toList();

    _listCardiologue.value = _listPersoMedical.where((e) => e.nomPoste == 'Cardiologue').toList();

    _listOncologue.value = _listPersoMedical.where((e) => e.nomPoste == 'Oncologue').toList();

    _listUrologue.value = _listPersoMedical.where((e) => e.nomPoste == 'Urologue').toList();

    _listInfirmier.value = _listPersoMedical.where((e) => e.nomPoste == 'Infirmier').toList();

    dev.log('doc généraliste fetched: ${_listMedecinGeneraliste.length}');
    dev.log('Cardiologue fetched: ${_listCardiologue.length}');
    dev.log('Oncologue fetched: ${_listOncologue.length}');
    dev.log('Urologue fetched: ${_listUrologue.length}');
    dev.log('Infirmier fetched: ${_listInfirmier.length}');

    return result2;
  }

  Future<List<Patient>> _getListPatient() async {
    final result = await _connection.query("SELECT * FROM afficherpatient");
    dev.log('patient fetched: ${result.length}');

    final result2 = List.generate(result.length, (i) {
      return Patient(
        noAvs: result[i][0],
        dateDeNaissance: result[i][5],
        nom: result[i][3],
        prenom: result[i][4],
      );
    });
    _listPatients.value = result2;

    return result2;
  }

  Future<List<Rdv>> _getListRdv() async {
    final result = await _connection.query("SELECT * FROM afficherrdvpatient");
    dev.log('rdv fetched: ${result.length}');
    final result2 = List.generate(result.length, (i) {
      return Rdv(
        id: result[i][0],
        date: result[i][1],
        prenomPatient: result[i][8],
        nomPatient: result[i][7],
        idPatient: result[i][2],
        idMedecin: result[i][6],
      );
    });

    _listRdv.value = result2;
    return result2;
  }

  Future<Employe> _getEmployee(int noAvs) async {
    final result = await _connection.query("SELECT * FROM get_employee($noAvs)");

    //  dev.log('employee fetched: ${result.length}');

    // Obligatoirement qu'un row car noAvs clé primaire
    final result2 = Employe(
        nomService: result[0][0],
        nomPoste: result[0][1],
        prenom: result[0][2],
        nom: result[0][3],
        noAvs: result[0][4],
        dateDeNaissance: result[0][5],
        pourcentageTravail: result[0][6]);

    return result2;
  }

  void _setSearchPath() async {
    await _connection.query(_searchPath);
  }
}
