import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  // Success snackbar
  static void success(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorClass.successColor,
      colorText: ColorClass.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  // Error snackbar
  static void error(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: ColorClass.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  // Info snackbar
  static void info(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: ColorClass.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  // Filter applied specific  case
  static void filterApplied(List<String> activeFilters, int resultCount) {
    success(
      'Filter Applied',
      activeFilters.isEmpty
          ? 'All filters cleared'
          : 'Found $resultCount doctors',
    );
  }

  // Filter cleared snackbar
  static void filterCleared() {
    info('Filters Cleared', 'All filters have been reset');
  }
}
