import 'package:doctor_finder_app/components/custom_snackbar.dart';
import 'package:doctor_finder_app/components/sizedbox.dart';
import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/constants/textstyle_class.dart';
import 'package:doctor_finder_app/getx_controller/doctor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFilterContainer extends StatelessWidget {
  final Function()? onSubmit;
  final Function()? onClear;

  const CustomFilterContainer({Key? key, this.onSubmit, this.onClear})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Text(
                      'Filter by',
                      style: TextStyleClass.primaryFont600(
                        24,
                        ColorClass.black,
                      ),
                    ),
                  ),
                  kHeight(30),
                  // Gender Section
                  buildGenderSection(controller),
                  kHeight(32),
                  // Divider
                  Container(height: 1, color: Colors.grey[300]),

                  // Time Section
                  buildTimeSection(controller),
                  kHeight(32),
                  buildActionButtons(controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleClear(DoctorController controller) {
    controller.clearFilters();
    onClear?.call();
    CustomSnackbar.filterCleared();
  }

  Widget buildGenderSection(DoctorController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyleClass.primaryFont600(18, ColorClass.black),
        ),
        kHeight(20),
        Obx(() {
          final selectedGender = controller.selectedGender.value;
          const genderOptions = ['Male', 'Female', 'Others'];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: genderOptions
                .map(
                  (gender) => buildGenderOption(
                    controller: controller,
                    gender: gender,
                    isSelected: selectedGender == gender,
                  ),
                )
                .toList(),
          );
        }),
      ],
    );
  }

  Widget buildGenderOption({
    required DoctorController controller,
    required String gender,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setGenderFilter(gender),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Text(
                gender.toUpperCase(),
                style: TextStyleClass.primaryFont500(
                  14,
                  ColorClass.primaryColor,
                ),
              ),
              kHeight(8),
              buildRadioButton(isSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton(bool isSelected) {
    return Radio<bool>(
      value: true,
      groupValue: isSelected,
      onChanged: null,
      activeColor: ColorClass.primaryColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget buildTimeSection(DoctorController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight(20),
        Text(
          'TIME',
          style: TextStyleClass.primaryFont600(18, ColorClass.black),
        ),
        kHeight(20),
        Obx(() {
          final selectedTime = controller.selectedTime.value;

          return Row(
            children: [
              Expanded(
                child: buildTimeOption(
                  controller,
                  'Morning',
                  '6:00 AM - 12:00 PM',
                  selectedTime,
                ),
              ),
              kWidth(16),
              Expanded(
                child: buildTimeOption(
                  controller,
                  'Evening',
                  '12:00 PM - 09:00 PM',
                  selectedTime,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget buildTimeOption(
    DoctorController controller,
    String timeSlot,
    String timeRange,
    String selectedTime,
  ) {
    final isSelected = selectedTime == timeSlot;

    return GestureDetector(
      onTap: () => controller.setTimeFilter(timeSlot),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? ColorClass.black : ColorClass.offGray,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            timeRange,
            style: TextStyleClass.primaryFont500(
              14,
              isSelected ? ColorClass.lightGray : ColorClass.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActionButtons(DoctorController controller) {
    return Column(
      children: [
        // Clear button (only show if filters are active)
        Obx(() {
          final hasActiveFilters = controller.hasActiveFilters;

          if (!hasActiveFilters) return const SizedBox.shrink();

          return Container(
            width: double.infinity,
            // margin: const EdgeInsets.only(bottom: 16),
            child: OutlinedButton(
              onPressed: () => handleClear(controller),
              style: OutlinedButton.styleFrom(
                // padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: ColorClass.primaryColor),
              ),
              child: Text(
                'CLEAR FILTERS',
                style: TextStyleClass.primaryFont600(16, ColorClass.black),
              ),
            ),
          );
        }),

        // Submit button
        buildSubmitButton(controller),
      ],
    );
  }

  Widget buildSubmitButton(DoctorController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          handleSubmit(controller);
          onSubmit?.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorClass.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          'SUBMIT',
          style: TextStyleClass.primaryFont500(16, ColorClass.white),
        ),
      ),
    );
  }

  void handleSubmit(DoctorController controller) {
    controller.applyFilters();

    final activeFilters = <String>[];

    if (controller.selectedGender.value != 'All') {
      activeFilters.add('Gender: ${controller.selectedGender.value}');
    }
    if (controller.selectedTime.value != 'All') {
      activeFilters.add('Time: ${controller.selectedTime.value}');
    }
    CustomSnackbar.filterApplied(
      activeFilters,
      controller.filteredDoctors.length,
    );
  }
}
