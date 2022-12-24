import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientListPage extends GetView {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des patients')),
      body: ListView(
        children: const [],
      ),
    );
  }
}
