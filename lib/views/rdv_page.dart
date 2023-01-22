import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';

import '../controllers/postgres_controller.dart';

class RdvPage extends GetView {
  RdvPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostgresController myController = Get.put(PostgresController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des rendez-vous'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/addRdv');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<List>>(
        future: myController.getListRdv(),
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
                        title: Text("Rendez-vous id :  " + item[0].toString()),
                        subtitle: Text("Date du rdv : " +
                            DateFormat('dd-MM-yyyy').format(item[1]) +
                            ' \nNom du patient ' +
                            item[8] +
                            " " +
                            item[7]),
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
