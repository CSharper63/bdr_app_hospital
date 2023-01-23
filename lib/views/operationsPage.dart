import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:bdr_hospital_app/models/operation.dart';
import 'package:flutter/material.dart';
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
                    return const Card(
                      child: ListTile(
                        leading: Icon(Icons.person_rounded),
                        title: Text(""),
                        subtitle: Text(""),
                      ),
                    );
                  },
                ))
            : const Center(child: CircularProgressIndicator())));
  }
}
