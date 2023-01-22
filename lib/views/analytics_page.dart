import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';

import '../controllers/postgres_controller.dart';

class AnalyticsPage extends GetView {
  AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostgresController myController = Get.put(PostgresController());
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: FutureBuilder<List<List>>(
        future: myController.getAnalytics(),
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
                          title: Text("Rendez-vous id : " + item[0].toString()),
                          subtitle: Text("Date : " +
                              DateFormat('dd-MM-yyyy').format(item[1]) +
                              "\nNom du patient : " +
                              item[8] +
                              " " +
                              item[7])),
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
