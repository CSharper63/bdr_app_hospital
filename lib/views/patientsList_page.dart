import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';

import '../controllers/postgres_controller.dart';

class PatientListPage extends GetView {
  PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostgresController myController = Get.put(PostgresController());
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des patients')),
      body: FutureBuilder<List<List>>(
        future: myController.getListPatient(),
        initialData: [],
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data![position];
                    //get your item data here ...
                    return Card(
                      child: ListTile(
                        title: Text("Nom du patient : " + item[4] + " " + item[3]),
                        subtitle:
                            Text("Date de naissance : " + DateFormat('dd-MM-yyyy').format(item[5])),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
