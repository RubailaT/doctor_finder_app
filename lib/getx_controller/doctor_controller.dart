import 'package:doctor_finder_app/domain/use_cases/doctor_use_cases.dart';
import 'package:doctor_finder_app/domain/use_cases/get_doctor_details_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/doctor.dart';

class DoctorController extends GetxController {
  final GetDoctorsUseCase _getDoctorsUseCase = Get.find<GetDoctorsUseCase>();
  final GetDoctorDetailsUseCase _getDoctorDetailsUseCase =
      Get.find<GetDoctorDetailsUseCase>();

  final RxList<Doctor> _doctors = <Doctor>[].obs;
  final RxList<Doctor> _filteredDoctors = <Doctor>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _searchQuery = ''.obs;
  final RxString _selectedGender = 'All'.obs;
  final RxString _selectedTime = 'All'.obs;

  List<Doctor> get doctors => _doctors;
  List<Doctor> get filteredDoctors => _filteredDoctors;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get searchQuery => _searchQuery.value;
  String get selectedGender => _selectedGender.value;
  String get selectedTime => _selectedTime.value;

  // Available gender options based on API data
  List<String> get genderOptions => ['All', 'Male', 'Female', 'Non-binary'];

  // Available time options based on API data
  List<String> get timeOptions => [
    'All',
    '08:00am',
    '09:00am',
    '10:00am',
    '11:00am',
    '12:00pm',
    '01:00pm',
    '02:00pm',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final doctors = await _getDoctorsUseCase.call();
      _doctors.assignAll(doctors);
      _applyFilters();
    } catch (e) {
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<Doctor?> getDoctorDetails(String id) async {
    try {
      return await _getDoctorDetailsUseCase.call(id);
    } catch (e) {
      _errorMessage.value = e.toString();
      return null;
    }
  }

  void setSearchQuery(String query) {
    _searchQuery.value = query;
    _applyFilters();
  }

  void setGenderFilter(String gender) {
    _selectedGender.value = gender;
    _applyFilters();
  }

  void setTimeFilter(String time) {
    _selectedTime.value = time;
    _applyFilters();
  }

  void clearFilters() {
    _selectedGender.value = 'All';
    _selectedTime.value = 'All';
    _searchQuery.value = '';
    _applyFilters();
  }

  void _applyFilters() {
    List<Doctor> filtered = _doctors.toList();

    // Apply search filter
    if (_searchQuery.value.isNotEmpty) {
      filtered = filtered.where((doctor) {
        return doctor.name.toLowerCase().contains(
              _searchQuery.value.toLowerCase(),
            ) ||
            doctor.department.toLowerCase().contains(
              _searchQuery.value.toLowerCase(),
            ) ||
            doctor.location.toLowerCase().contains(
              _searchQuery.value.toLowerCase(),
            );
      }).toList();
    }

    // Apply gender filter
    if (_selectedGender.value != 'All') {
      filtered = filtered
          .where((doctor) => doctor.gender == _selectedGender.value)
          .toList();
    }

    // Apply time filter
    if (_selectedTime.value != 'All') {
      filtered = filtered
          .where((doctor) => doctor.time.contains(_selectedTime.value))
          .toList();
    }

    _filteredDoctors.assignAll(filtered);
  }
}
