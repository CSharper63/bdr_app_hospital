import 'dart:developer' as dev;

import 'package:bdr_hospital_app/services/postgres_service.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';

class PostgresController extends GetxController {
  final _connection = PostgreSQLConnection(
      PostgresService.host, PostgresService.port, PostgresService.databaseName,
      username: PostgresService.username, password: PostgresService.password);
  @override
  Future<void> onInit() async {
    super.onInit();
    dev.log('PostgresController onInit');
    await _connection
        .open()
        .then((_) => dev.log('Connection success'))
        .catchError((onError) {
      dev.log('Error: $onError');
    });
  }
}
