import 'package:doctor_finder_app/components/sizedbox.dart';
import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/constants/textstyle_class.dart';
import 'package:flutter/material.dart';

class DoctorDetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  const DoctorDetailCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,

    this.margin = const EdgeInsets.only(bottom: 16),
    this.padding = const EdgeInsets.all(16),
    // this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: ColorClass.blueLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorClass.lightGray),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 25),
          ),
          kWidth(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyleClass.primaryFont500(14, ColorClass.bgDark),
                ),
                kHeight(4),
                Text(
                  value,
                  style: TextStyleClass.primaryFont600(14, ColorClass.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
