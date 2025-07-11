import 'package:doctor_finder_app/components/custom_search_bar.dart';
import 'package:doctor_finder_app/components/filter_bottom_sheet.dart';
import 'package:doctor_finder_app/components/doctor_shimmer.dart';
import 'package:doctor_finder_app/components/sizedbox.dart';
import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/constants/textstyle_class.dart';
import 'package:doctor_finder_app/core/utils/app_utils.dart';
import 'package:doctor_finder_app/getx_controller/doctor_controller.dart';
import 'package:doctor_finder_app/screens/doctor_list_screen/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({Key? key}) : super(key: key);

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  bool showFilters = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorController>();

    return Scaffold(
      backgroundColor: ColorClass.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  kHeight(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Find  Your\nDoctor',
                        style: TextStyleClass.primaryFont700(
                          30,
                          ColorClass.black,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ColorClass.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return CustomFilterContainer(
                                  onSubmit: () {
                                    controller.applyFilters();
                                    Navigator.of(context).pop();
                                  },
                                  onClear: () {
                                    controller.clearFilters();
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.tune),
                          color: Colors.white,
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  kHeight(16),
                  CustomSearchBar(
                    controller: searchController,
                    onChanged: (value) {
                      controller.setSearchQuery(value);
                    },
                  ),
                  kHeight(16),
                ],
              ),
            ),
            // Scrollable content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: buildDoctorsSection(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoctorsSection(DoctorController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Updated to show doctor count
        Obx(() {
          return Text(
            'Doctors near you (${controller.filteredDoctors.length})',

            style: TextStyleClass.primaryFont500(18, ColorClass.primaryColor),
          );
        }),

        kHeight(16),
        Expanded(
          child: Obx(() {
            final isLoading = controller.isLoading;
            final filteredDoctors = controller.filteredDoctors;

            if (isLoading.value) {
              return DoctorCardShimmer();
            }

            if (filteredDoctors.isEmpty) {
              return AppUtils.noDataFound(
                "No doctors found",
                "Try adjusting your search criteria or filters",
                context,
              );
            }

            return RefreshIndicator(
              onRefresh: () => controller.fetchDoctors(),
              color: ColorClass.primaryColor,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return kHeight(10);
                },
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return DoctorCard(doctor: doctor);
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
