import 'dart:developer' as dev;

import 'package:bdr_hospital_app/services/postgres_service.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';

class PostgresController extends GetxController {
  final String _searchPath = 'SET search_path TO hopital;';
  final _connection = PostgreSQLConnection(
      PostgresService.host, PostgresService.port, PostgresService.databaseName,
      username: PostgresService.username, password: PostgresService.password);

  final RxList<List> _listPatients = RxList();
  final RxList<List> _listRdv = RxList();
  final RxList<List> _listAnalytics = RxList();

  List<List> get listAnalytics => _listAnalytics.value;
  List<List> get listPatients => _listPatients.value;
  List<List> get listRdv => _listRdv.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    dev.log('PostgresController onInit');
    await _connection.open().then((_) {
      dev.log('Connection success');
      _setSearchPath();

      // our queries
      _getAnalytics();
      _getListPatient();
      _getListRdv();
    }).catchError((onError) {
      dev.log('Error: $onError');
    });
  }

  Future<List<List>> _getAnalytics() async {
    final result = await _connection.query(" SELECT * FROM afficheranalytics");

    dev.log('analytics fetched: ${result.length}');

    dev.log('result: $result');
    _listAnalytics.value = result;

    return result;
  }

  Future<List<List>> _getListPatient() async {
    final result = await _connection.query(" SELECT * FROM afficherpatient");
    dev.log('patient fetched: ${result.length}');
    _listPatients.value = result;

    return result;
  }

  Future<List<List>> _getListRdv() async {
    final result = await _connection.query(" SELECT * FROM afficherrdvpatient");
    dev.log('rdv fetched: ${result.length}');
    _listRdv.value = result;
    return result;
  }

  void _setSearchPath() async {
    await _connection.query(_searchPath);
  }
}
