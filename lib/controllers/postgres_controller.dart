import 'package:bdr_hospital_app/services/postgres_service.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';

class PostgresController extends GetxController {
  final String _searchPath = 'SET search_path TO hopital;';
  var _connection = PostgreSQLConnection(
      PostgresService.host, PostgresService.port, PostgresService.databaseName,
      username: PostgresService.username, password: PostgresService.password);

  Future<List<List>> getListPatient() async {
    var results;

    await _connection.open().then((_) async {
      _setSearchPath();

      return results = await _connection.query(" SELECT * FROM afficherpatient");
    });

    return results;
  }

  Future<List<List>> getListRdv() async {
    var results;

    await _connection.open().then((_) async {
      _setSearchPath();

      return results = await _connection.query(" SELECT * FROM afficherrdvpatient");
    });

    return results;
  }

  Future<List<List>> getAnalytics() async {
    var results;

    await _connection.open().then((_) async {
      _setSearchPath();

      return results = await _connection.query(" SELECT * FROM afficheranalytics");
    });

    return results;
  }

  void _setSearchPath() async {
    await _connection.query(_searchPath);
  }
}
