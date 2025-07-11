import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/utils/network_service.dart';
import 'package:doctor_finder_app/getx_controller/doctor_controller.dart';
import 'package:doctor_finder_app/screens/doctor_list_screen/doctors_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Initialize dependencies
  Get.put(NetworkService());
  Get.put(DoctorController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doctor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorClass.primaryColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorClass.primaryColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const DoctorListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
