import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:bdr_hospital_app/models/operation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class OperationsPage extends GetView<PostgresController> {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Liste des opérations')),
        body: Obx(() => controller.dbStatus == DbStatus.connected
            ? Obx(() => ListView.builder(
                  itemCount: controller.listOperation.length,
                  itemBuilder: (_, int position) {
                    final Operation op = controller.listOperation[position];
                    //get your item data here ...
                    return Card(
                      child: ListTile(
                        title: Text(op.nomPosteChirurgien),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.person_rounded),
                                  Text(
                                      '${op.patient.prenom} ${op.patient.nom}'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.userDoctor,
                                    size: 20,
                                  ),
                                  Text(
                                      '${op.employe.prenom} ${op.employe.nom}'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Description : ${op.description}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Durée de covalécance : ${op.dureeConvalescence} jour(s)')
                            ]),
                      ),
                    );
                  },
                ))
            : const Center(child: CircularProgressIndicator())));
  }
}
