import 'package:bdr_hospital_app/controllers/NavigationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetView<NavigationController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Obx(() => controller.pages.elementAt(controller.selectedIndex))),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list_rounded), label: 'Liste rendez-vous'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medical_information_rounded), label: 'Liste des patients'),
              BottomNavigationBarItem(icon: Icon(Icons.numbers), label: 'Analytics'),
            ],
            currentIndex: controller.selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: (int idx) {
              controller.setIndex = idx;
            },
          ),
        ));
  }
}
