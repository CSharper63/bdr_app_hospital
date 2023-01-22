import 'dart:developer' as dev;

import 'package:bdr_hospital_app/models/personne.dart';
import 'package:bdr_hospital_app/services/postgres_service.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';

class PostgresController extends GetxController {
  final String _searchPath = 'SET search_path TO hopital;';
  final _connection = PostgreSQLConnection(
      PostgresService.host, PostgresService.port, PostgresService.databaseName,
      username: PostgresService.username, password: PostgresService.password);
  @override
  Future<void> onInit() async {
    super.onInit();
    dev.log('PostgresController onInit');
    await _connection.open().then((_) {
      dev.log('Connection success');
      _setSearchPath();
      _fetchMedecin();
      _fetchPatient();
      _fetchRdv();
    }).catchError((onError) {
      dev.log('Error: $onError');
    });
  }

  void _fetchMedecin() async {
    final result = await _connection.query(' SELECT * FROM personne');

    for (var row in result.toList()) {
      dev.log('row: $row');

      var p = Personne.fromPostgre(row);

      dev.log('p: $p');
    }
  }

  void _fetchPatient() async {
    final result = await _connection.query(' SELECT * FROM patient');
    dev.log('result: $result');
  }

  void _fetchRdv() async {
    final result = await _connection.query(' SELECT * FROM rendezvous');
    dev.log('result: $result');
  }

  void _setSearchPath() async {
    final result = await _connection.query(_searchPath);
    dev.log('result: $result');
  }
}
