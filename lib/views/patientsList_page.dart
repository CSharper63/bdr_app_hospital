import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:bdr_hospital_app/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientListPage extends GetView<PostgresController> {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt selectedDoc = controller.listEmployees[0].noAvs.obs;
    return Scaffold(
        appBar: AppBar(title: const Text('Liste des patients'), actions: [
          IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: () {
                Get.defaultDialog(
                    title: 'Nouveau patient',
                    content: Column(children: [
                      TextFormField(
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'John',
                            labelText: 'Prénom *',
                          )),
                      TextFormField(
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Doe',
                            labelText: 'Nom *',
                          )),
                      TextFormField(
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.cake_rounded),
                            hintText: '2000-01-01',
                            labelText: 'Date de naissance *',
                          )),
                      Obx(
                        () => DropdownButton(
                          value: selectedDoc.value ?? 0,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: controller.listEmployees.map((e) {
                            return DropdownMenuItem(
                              value: e.noAvs,
                              child: Text('${e.prenom} ${e.nom}'),
                            );
                          }).toList(),
                          onChanged: (int? value) {
                            selectedDoc.value = value ?? selectedDoc.value;
                          },
                        ),
                      )
                    ]));
              }),
        ]),
        body: Obx(() => controller.dbStatus == DbStatus.connected
            ? Obx(() => ListView.builder(
                  itemCount: controller.listPatients.length,
                  itemBuilder: (_, int position) {
                    final Patient patient = controller.listPatients[position];
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
                ))
            : const Center(child: CircularProgressIndicator())));
  }
}
