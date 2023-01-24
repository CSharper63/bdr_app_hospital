import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:bdr_hospital_app/models/employe.dart';
import 'package:bdr_hospital_app/models/employeService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AnalyticsPage extends GetView<PostgresController> {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle txtStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: Obx(() => controller.dbStatus == DbStatus.connected
            ? ListView(children: [
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
                    child: Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.listEmployeesService.length,
                          itemBuilder: (_, int position) {
                            final EmployeService service =
                                controller.listEmployeesService[position];
                            print(service);
                            //get your item data here ...
                            return ListTile(
                              leading: const Icon(
                                FontAwesomeIcons.userDoctor,
                                size: 20,
                              ),
                              title: Text(
                                  "${service.nomService} ${service.nbEmploye}"),
                            );
                          },
                        ))),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                        'Médecins généraliste ${controller.listMedecinGeneraliste.length}',
                        style: txtStyle)),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.listMedecinGeneraliste.length,
                          itemBuilder: (_, int position) {
                            final Employe doc =
                                controller.listMedecinGeneraliste[position];
                            //get your item data here ...
                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.userDoctor,
                                  size: 20,
                                ),
                                title: Text("${doc.prenom} ${doc.nom}"),
                                subtitle: Text(
                                    "Taux de travail : ${doc.pourcentageTravail * 100}%"),
                              ),
                            );
                          },
                        ))),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Text('Urologue ${controller.listUrologue.length}',
                        style: txtStyle)),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.listUrologue.length,
                          itemBuilder: (_, int position) {
                            final Employe doc =
                                controller.listUrologue[position];
                            //get your item data here ...
                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.userDoctor,
                                  size: 20,
                                ),
                                title: Text("${doc.prenom} ${doc.nom}"),
                                subtitle: Text(
                                    "Taux de travail : ${doc.pourcentageTravail * 100}%"),
                              ),
                            );
                          },
                        ))),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'Oncologue ${controller.listOncologue.length}',
                      style: txtStyle,
                    )),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.listOncologue.length,
                          itemBuilder: (_, int position) {
                            final Employe doc =
                                controller.listOncologue[position];
                            //get your item data here ...
                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.userDoctor,
                                  size: 20,
                                ),
                                title: Text("${doc.prenom} ${doc.nom}"),
                                subtitle: Text(
                                    "Taux de travail : ${doc.pourcentageTravail * 100}%"),
                              ),
                            );
                          },
                        ))),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Text('Infirmier ${controller.listInfirmier.length}',
                        style: txtStyle)),
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Obx(() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.listInfirmier.length,
                          itemBuilder: (_, int position) {
                            final Employe doc =
                                controller.listInfirmier[position];
                            //get your item data here ...
                            return Card(
                              child: ListTile(
                                leading: const Icon(
                                  FontAwesomeIcons.userNurse,
                                  size: 20,
                                ),
                                title: Text("${doc.prenom} ${doc.nom}"),
                                subtitle: Text(
                                    "Taux de travail : ${doc.pourcentageTravail * 100}%"),
                              ),
                            );
                          },
                        ))),
              ])
            : const Center(child: CircularProgressIndicator())));
  }
}
