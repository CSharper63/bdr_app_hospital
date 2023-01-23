import 'package:bdr_hospital_app/views/analytics_page.dart';
import 'package:bdr_hospital_app/views/patientsList_page.dart';
import 'package:bdr_hospital_app/views/profile_page.dart';
import 'package:bdr_hospital_app/views/rdv_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _pages = [
    RdvPage(),
    const PatientListPage(),
    const AnalyticsPage(),
    const ProfilePage()
  ];
  List<Widget> get pages => _pages;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int index) => _selectedIndex.value = index;
  set setIndex(int idx) => _selectedIndex.value = idx;
}
