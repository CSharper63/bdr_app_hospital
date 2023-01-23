import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RdvPage extends GetView<PostgresController> {
  String _newToUpate = '';

  final RxBool _canUpdate = false.obs;
  RdvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: () {
                Get.defaultDialog(
                    content: Column(
                  children: [
                    TextFormField(
                        validator: (String? value) {
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'What do people call you?',
                          labelText: 'Name *',
                        )),
                  ],
                ));
              },
            )
          ],
          title: const Text('Liste des rendez-vous'),
        ),
        body: Obx(() => controller.dbStatus == DbStatus.connected
            ? Obx(() => ListView.builder(
                  itemCount: controller.listRdv.length,
                  itemBuilder: (_, int position) {
                    final rdv = controller.listRdv[position];

                    //get your rdv data here ...
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.calendar_month_rounded),
                        title: Text(
                            "Date : ${DateFormat('dd-MM-yyyy').format(rdv.date)} "),
                        subtitle: Text(
                            "Patient : ${rdv.prenomPatient} ${rdv.nomPatient}"),
                        trailing: const Icon(Icons.edit_rounded),
                        onTap: () async {
                          Get.defaultDialog(
                              title: "Mise à jour",
                              content: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      const Text(
                                          'Veuillez choisir une nouvelle date de rendez-vous'),
                                      DateTimePicker(
                                        type: DateTimePickerType.date,
                                        initialValue: '',
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        dateLabelText:
                                            'Choisir une nouvelle date',
                                        onChanged: (val) {
                                          _newToUpate = val;
                                          _canUpdate.value = true;
                                        },
                                        validator: (val) {
                                          _newToUpate = val ?? '';
                                          return null;
                                        },
                                        onSaved: (val) => print(val),
                                      ),
                                      Obx(() => IconButton(
                                          onPressed: _canUpdate.value
                                              ? () async {
                                                  bool updated =
                                                      await controller
                                                          .updateRdv(rdv.id,
                                                              _newToUpate);

                                                  if (updated) {
                                                    Get.back(
                                                        closeOverlays: true);
                                                    Get.showSnackbar(
                                                        GetSnackBar(
                                                      message:
                                                          "Rendez-vous ${rdv.id} mis à jour !",
                                                      duration: const Duration(
                                                          seconds: 1),
                                                    ));
                                                    _canUpdate.value = false;
                                                  } else {
                                                    Get.back(
                                                        closeOverlays: true);
                                                  }
                                                }
                                              : null,
                                          icon:
                                              const Icon(Icons.check_rounded)))
                                    ],
                                  )));
                        },
                      ),
                    );
                  },
                ))
            : const Center(child: CircularProgressIndicator())));
  }
}
