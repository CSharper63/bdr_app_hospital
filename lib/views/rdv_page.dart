import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RdvPage extends GetView<PostgresController> {
  const RdvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des rendez-vous'),
        ),
        body: Obx(() => ListView.builder(
              itemCount: controller.listRdv.length,
              itemBuilder: (_, int position) {
                final item = controller.listRdv[position];

                //get your item data here ...
                return Card(
                  child: ListTile(
                    title: Text("Rendez-vous id :  ${item[0]}"),
                    subtitle: Text(
                        "${"Date du rdv : " + DateFormat('dd-MM-yyyy').format(item[1]) + ' \nNom du patient ' + item[8]} " +
                            item[7]),
                    onTap: () {},
                  ),
                );
              },
            )));
  }
}
