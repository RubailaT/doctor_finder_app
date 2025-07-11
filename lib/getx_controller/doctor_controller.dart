import 'package:doctor_finder_app/core/constants/api_urls.dart';
import 'package:doctor_finder_app/core/utils/network_service.dart';
import 'package:doctor_finder_app/data/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {
  final NetworkService networkService = Get.find<NetworkService>();

  // Observable variables
  var allDoctors = <DoctorDataModel>[].obs;
  var filteredDoctors = <DoctorDataModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Filter variables
  var searchQuery = ''.obs;
  var selectedGender = 'All'.obs;
  var selectedTime = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  // Fetch doctors from API
  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('🔄 Fetching doctors from API...');
      final List<dynamic> response = await networkService.getDoctorsDataList();
      final doctorsList = response
          .map((json) => DoctorDataModel.fromJson(json))
          .toList();

      allDoctors.assignAll(doctorsList);
      print('✅ Successfully fetched ${doctorsList.length} doctors');

      applyFilters();
    } catch (e) {
      print('❌ API call failed: $e');
      errorMessage.value =
          'Failed to load doctors. Please check your internet connection.';
      allDoctors.clear();
      filteredDoctors.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Get doctor details by ID
  Future<DoctorDataModel?> getDoctorDetails(String id) async {
    try {
      // First check local data
      final localDoctor = allDoctors.firstWhereOrNull(
        (doctor) => doctor.id == id,
      );
      if (localDoctor != null) {
        return localDoctor;
      }

      // If not found locally, try API
      final Map<String, dynamic> response = await networkService.get(
        ApiUrls.getDoctorDetailsById(id),
      );
      return DoctorDataModel.fromJson(response);
    } catch (e) {
      print('❌ Failed to get doctor details: $e');
      return null;
    }
  }

  // Filter methods
  void setSearchQuery(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void setGenderFilter(String gender) {
    selectedGender.value = gender;
    applyFilters();
  }

  void setTimeFilter(String time) {
    selectedTime.value = time;
    applyFilters();
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedGender.value = 'All';
    selectedTime.value = 'All';
    applyFilters();
  }

  // Apply all filters
  void applyFilters() {
    List<DoctorDataModel> filtered = allDoctors.toList();

    print('=== FILTERING ===');
    print('Starting with ${filtered.length} doctors');
    print(
      'Filters: Gender="${selectedGender.value}", Time="${selectedTime.value}", Search="${searchQuery.value}"',
    );

    // Search filter
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((doctor) {
        return doctor.name.toLowerCase().contains(query) ||
            doctor.department.toLowerCase().contains(query) ||
            doctor.location.toLowerCase().contains(query);
      }).toList();
      print('After search: ${filtered.length} doctors');
    }

    // Gender filter
    if (selectedGender.value != 'All') {
      filtered = filtered.where((doctor) {
        final doctorGender = doctor.gender.toString().toLowerCase();

        if (selectedGender.value == 'Others') {
          // "Others" includes everything except Male and Female
          return doctorGender != 'male' && doctorGender != 'female';
        } else {
          // Exact match for Male/Female
          return doctorGender == selectedGender.value.toLowerCase();
        }
      }).toList();
      print('After gender filter: ${filtered.length} doctors');
    }

    // Time filter
    if (selectedTime.value != 'All') {
      filtered = filtered.where((doctor) {
        final timeStr = doctor.time.toLowerCase();

        if (selectedTime.value == 'Morning') {
          // Morning: 6am-11:59am
          return timeStr.contains('6:00am') ||
              timeStr.contains('7:00am') ||
              timeStr.contains('8:00am') ||
              timeStr.contains('9:00am') ||
              timeStr.contains('10:00am') ||
              timeStr.contains('11:00am') ||
              timeStr.contains('6am') ||
              timeStr.contains('7am') ||
              timeStr.contains('8am') ||
              timeStr.contains('9am') ||
              timeStr.contains('10am') ||
              timeStr.contains('11am');
        } else if (selectedTime.value == 'Evening') {
          // Evening: 12pm onwards
          return timeStr.contains('12:00pm') ||
              timeStr.contains('1:00pm') ||
              timeStr.contains('2:00pm') ||
              timeStr.contains('3:00pm') ||
              timeStr.contains('4:00pm') ||
              timeStr.contains('5:00pm') ||
              timeStr.contains('6:00pm') ||
              timeStr.contains('7:00pm') ||
              timeStr.contains('8:00pm') ||
              timeStr.contains('9:00pm') ||
              timeStr.contains('12pm') ||
              timeStr.contains('1pm') ||
              timeStr.contains('2pm') ||
              timeStr.contains('3pm') ||
              timeStr.contains('4pm') ||
              timeStr.contains('5pm') ||
              timeStr.contains('6pm') ||
              timeStr.contains('7pm') ||
              timeStr.contains('8pm') ||
              timeStr.contains('9pm');
        }
        return false;
      }).toList();
      print('After time filter: ${filtered.length} doctors');
    }

    filteredDoctors.assignAll(filtered);
    print('=== FINAL RESULT: ${filtered.length} doctors ===');
  }

  // Helper getter
  bool get hasActiveFilters {
    return selectedGender.value != 'All' ||
        selectedTime.value != 'All' ||
        searchQuery.value.isNotEmpty;
  }
}
