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
                        "Nombre d'opérations reprogrammés : ${controller.listAnalytics[0][1]}")

                    /* subtitle: Text(
                          "${"Date : " + DateFormat('dd-MM-yyyy').format(item[1]) + "\nNom du patient : " + item[8]} " +
                              item[7]) */
                    ),
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Etat des services",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("Chirurgie : "),
                  Text("Oncologie : "),
                  Text("Cardiologie : "),
                  Text("Reception : "),
                  Text("Urologie : "),
                ],
              ))
        ]));
  }
}
