import 'package:bdr_hospital_app/bindings/bindings.dart';
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
      initialBinding: AppBindings(),
      home: const Root(),
    );
  }
}
