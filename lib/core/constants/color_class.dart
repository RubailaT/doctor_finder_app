import 'package:flutter/material.dart';

class ColorClass {
  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color green = Colors.green;
  static const Color orange = Colors.orange;
  static const Color purple = Colors.purple;
  static const Color backgroundColor = Color(0xffFFFFFF);
  static const Color successColor = Color(0xFF27AE60);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color textGray = Color(0xff9EA2AD);
  static const Color textBlack = Color(0xff333333);
  static const Color lightGray = Color(0xffE2E4E9);
  static const Color offGray = Color(0xffD0D0D0);
  static const Color borderGray = Color(0xffE9EAEB);
  static const Color blueLight = Color(0xffC2D6FF);
  static const Color bgDark = Color(0xff342F3F);
  static const Color textSub500 = Color(0xff525866);
  static const Color textSoft400 = Color(0xff868C98);

  Color getDepartmentColor(String department) {
    switch (department.toUpperCase()) {
      case 'PEDIATRICS':
        return const Color(0xFF4A90E2);
      case 'PSYCHIATRY':
        return const Color(0xFF9B59B6);
      case 'GASTROLOGY':
      case 'GASTROENTEROLOGY':
        return const Color(0xFF3498DB);
      case 'DERMATOLOGY':
        return const Color(0xFFE74C3C);
      case 'CARDIOLOGY':
        return const Color(0xFFE67E22);
      case 'NEUROLOGY':
        return const Color(0xFF8E44AD);
      case 'ORTHOPEDICS':
        return const Color(0xFF27AE60);
      case 'ENT':
        return const Color(0xFFF39C12);
      case 'GYNECOLOGY':
        return const Color(0xFFE91E63);
      case 'UROLOGY':
        return const Color(0xFF00BCD4);
      case 'RADIOLOGY':
        return const Color(0xFF795548);
      case 'GENERAL MEDICINE':
        return const Color(0xFF607D8B);
      default:
        return const Color(0xFF4A90E2);
    }
  }
}
