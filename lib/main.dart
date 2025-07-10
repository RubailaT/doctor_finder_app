import 'package:doctor_finder_app/core/netwrok/network_service.dart';
import 'package:doctor_finder_app/data/data_sources/doctor_remote_data_sources.dart';
import 'package:doctor_finder_app/domain/use_cases/doctor_use_cases.dart';
import 'package:doctor_finder_app/domain/use_cases/get_doctor_details_use_case.dart';
import 'package:doctor_finder_app/getx_controller/doctor_controller.dart';
import 'package:doctor_finder_app/screens/doctor_list_screen/doctors_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/constants/app_colors.dart';
import 'data/repositories/doctor_repository_impl.dart';

void main() {
  // Initialize dependencies
  Get.put(NetworkService());
  Get.put(DoctorRemoteDataSource());
  Get.put(DoctorRepositoryImpl());
  Get.put(GetDoctorsUseCase());
  Get.put(GetDoctorDetailsUseCase());
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
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      home: const DoctorListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
