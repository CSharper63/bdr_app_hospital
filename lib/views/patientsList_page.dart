import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:bdr_hospital_app/models/patient.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientListPage extends GetView<PostgresController> {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController firstname = TextEditingController();
    RxInt selectedDoc = controller.listPersoMedical[0].noAvs.obs;
    String birthDate;
    return Scaffold(
        appBar: AppBar(title: const Text('Liste des patients'), actions: [
          IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: () {
                Get.defaultDialog(
                    title: 'Nouveau patient',
                    content: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Column(children: [
                          TextFormField(
                              controller: firstname,
                              validator: (String? value) {
                                return null;
                              },
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: 'John',
                                labelText: 'Prénom *',
                              )),
                          TextFormField(
                              controller: name,
                              validator: (String? value) {
                                return null;
                              },
                              decoration: const InputDecoration(
                                icon: Icon(Icons.person),
                                hintText: 'Doe',
                                labelText: 'Nom *',
                              )),
                          DateTimePicker(
                            type: DateTimePickerType.date,
                            icon: const Icon(Icons.cake_rounded),
                            initialValue: '',
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Date de naissance',
                            onChanged: (val) {
                              birthDate = val;
                            },
                            validator: (val) {
                              birthDate = val ?? '';
                              return null;
                            },
                            onSaved: (val) => print(val),
                          ),
                          Obx(
                            () => DropdownButton(
                              value: selectedDoc.value ?? 0,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: controller.listPersoMedical.map((e) {
                                return DropdownMenuItem(
                                  value: e.noAvs,
                                  child: Text(
                                    '${e.prenom} ${e.nom}, (${e.nomService})',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                selectedDoc.value = value ?? selectedDoc.value;
                              },
                            ),
                          )
                        ])));
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
