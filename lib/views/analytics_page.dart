import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsPage extends GetView<PostgresController> {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: ListView(children: [
          Obx(() => Card(
                child: ListTile(
                  title: Text(
                      "Nombre de rendez-vous reprogrammés : ${controller.listAnalytics[0][0]}"),

                  /* subtitle: Text(
                          "${"Date : " + DateFormat('dd-MM-yyyy').format(item[1]) + "\nNom du patient : " + item[8]} " +
                              item[7]) */
                ),
              )),
          Obx(() => Card(
                child: ListTile(
                    title: Text(
                        "Nombre d'opérations reprogrammés : ${controller.listAnalytics[0][0]}")

                    /* subtitle: Text(
                          "${"Date : " + DateFormat('dd-MM-yyyy').format(item[1]) + "\nNom du patient : " + item[8]} " +
                              item[7]) */
                    ),
              )),
        ]));
  }
}
