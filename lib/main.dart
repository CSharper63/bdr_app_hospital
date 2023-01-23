import 'package:bdr_hospital_app/bindings/bindings.dart';
import 'package:bdr_hospital_app/controllers/postgres_controller.dart';
import 'package:bdr_hospital_app/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        )),
        initialBinding: AppBindings(),
        home: Obx(
          () => Get.find<PostgresController>().dbStatus == DbStatus.connected
              ? const Root()
              : const Splash(),
        ));
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
