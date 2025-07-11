import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final VoidCallback? onSearchPressed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? searchButtonColor;
  final Color? hintTextColor;
  final double? borderRadius;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search Your Doctor',
    this.onSearchPressed,
    this.margin = const EdgeInsets.all(24),
    this.padding,
    this.backgroundColor = const Color(0xFFF8F9FE),
    this.searchButtonColor = const Color(0xFF4A90E2),
    this.hintTextColor = const Color(0xFF9B9B9B),
    this.borderRadius = 25,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Container(
        decoration: BoxDecoration(
          color: ColorClass.borderGray,
          borderRadius: BorderRadius.circular(borderRadius!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: prefixIcon!,
              ),
            ],
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                enabled: enabled,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: hintTextColor, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding:
                      padding ??
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            if (suffixIcon != null) ...[
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: suffixIcon!,
              ),
            ] else ...[
              IconButton(
                onPressed:
                    onSearchPressed ??
                    () {
                      if (controller.text.isNotEmpty) {
                        onChanged(controller.text);
                      }
                    },
                icon: const Icon(
                  Icons.search,
                  color: ColorClass.primaryColor,
                  size: 30,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
