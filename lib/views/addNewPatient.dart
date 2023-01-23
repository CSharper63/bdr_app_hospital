import 'dart:math';

import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPatientPage extends GetView<PostgresController> {
  const AddPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController firstname = TextEditingController();
    TextEditingController rue = TextEditingController();
    TextEditingController npa = TextEditingController();
    TextEditingController ville = TextEditingController();
    TextEditingController pays = TextEditingController();
    TextEditingController numRue = TextEditingController();

    RxInt selectedDoc = controller.listPersoMedical[0].noAvs.obs;
    String selectedDocStrService = '';
    String birthDate = '';
    double space = 20;
    return Scaffold(
        appBar: AppBar(title: const Text('Ajouter un patient')),
        body: Obx(() => controller.dbStatus == DbStatus.connected
            ? ListView(children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
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
                          SizedBox(
                            height: space,
                          ),
                          TextFormField(
                              controller: npa,
                              validator: (String? value) {
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: '1400',
                                labelText: 'NPA *',
                              )),
                          TextFormField(
                              controller: rue,
                              keyboardType: TextInputType.streetAddress,
                              validator: (String? value) {
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Chemin de la strasse',
                                labelText: 'Rue *',
                              )),
                          TextFormField(
                              controller: numRue,
                              keyboardType: TextInputType.number,
                              validator: (String? value) {
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: '47',
                                labelText: 'Numéro *',
                              )),
                          TextFormField(
                              controller: ville,
                              validator: (String? value) {
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Yverdon',
                                labelText: 'Ville *',
                              )),
                          TextFormField(
                              controller: pays,
                              validator: (String? value) {
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Suisse',
                                labelText: 'Pays *',
                              )),
                          SizedBox(
                            height: space,
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
                                selectedDocStrService = controller
                                    .listPersoMedical
                                    .firstWhere((e) => e.noAvs == value)
                                    .nomPoste;
                              },
                            ),
                          )
                        ])),
                IconButton(
                    onPressed: () async {
                      Random random = Random();
                      bool inserted = await controller.insertPatient(
                        nomPosteMedecinTraitant: selectedDocStrService,
                        pays: pays.text.trim(),
                        numeroRue: numRue.text.trim(),
                        rue: rue.text.trim(),
                        ville: ville.text.trim(),
                        npa: npa.text.trim(),
                        nom: name.text.trim(),
                        prenom: firstname.text.trim(),
                        idMedecinTraitant: selectedDoc.value,
                        dateNaissance: birthDate,
                        noAvs: random.nextInt(1000000000),
                      );

                      if (inserted) {
                        print('INSERTEDDDDDDDDDDDDDDDDD');
                      }
                    },
                    icon: const Icon(Icons.add_rounded)),
                SizedBox(
                  height: space,
                ),
              ])
            : const Center(child: CircularProgressIndicator())));
  }
}
