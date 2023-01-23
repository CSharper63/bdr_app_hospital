import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:bdr_hospital_app/models/patient.dart';
import 'package:bdr_hospital_app/views/addNewPatient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientListPage extends GetView<PostgresController> {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            label: Row(
              children: const [
                Text('Ajouter un patient'),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.add_rounded)
              ],
            ),
            onPressed: () {
              Get.to(() => const AddPatientPage());
            }),
        appBar: AppBar(title: const Text('Liste des patients')),
        body: Obx(() => controller.dbStatus == DbStatus.connected
            ? Obx(() => ListView.builder(
                  itemCount: controller.listPatients.length,
                  itemBuilder: (_, int position) {
                    final Patient patient = controller.listPatients[position];
                    //get your item data here ...
                    return Card(
                      child: ListTile(
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: Color.fromARGB(255, 212, 16, 16),
                          ),
                          onPressed: () async {
                            final isDeleted =
                                await controller.deletePatient(patient.noAvs);

                            if (isDeleted) {
                              Get.showSnackbar(const GetSnackBar(
                                message: 'Patient supprimé avec succès !',
                                duration: Duration(seconds: 1),
                              ));
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                message: 'Suppression impossible.',
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                        ),
                        leading: const Icon(Icons.person_rounded),
                        title: Text("${patient.prenom} ${patient.nom}"),
                        subtitle: Text(
                            "Date de naissance : ${DateFormat('dd-MM-yyyy').format(patient.dateDeNaissance)}"),
                      ),
                    );
                  },
                ))
            : const Center(child: CircularProgressIndicator())));
  }
}
