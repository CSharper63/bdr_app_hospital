import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientListPage extends GetView<PostgresController> {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Liste des patients')),
        body: Obx(() => ListView.builder(
              itemCount: controller.listPatients.length,
              itemBuilder: (_, int position) {
                final patient = controller.listPatients[position];
                //get your item data here ...
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person_rounded),
                    title: Text("${patient.prenom} ${patient.nom}"),
                    subtitle: Text(
                        "Date de naissance : ${DateFormat('dd-MM-yyyy').format(patient.dateDeNaissance)}"),
                  ),
                );
              },
            )));
  }
}
