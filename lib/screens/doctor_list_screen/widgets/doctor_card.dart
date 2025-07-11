import 'package:doctor_finder_app/components/sizedbox.dart';
import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/constants/textstyle_class.dart';
import 'package:doctor_finder_app/core/utils/app_utils.dart';
import 'package:doctor_finder_app/data/model/doctor_model.dart';
import 'package:doctor_finder_app/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorCard extends StatelessWidget {
  final DoctorDataModel doctor;
  final VoidCallback? onTap;

  const DoctorCard({Key? key, required this.doctor, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Get.to(
              () => DoctorDetailsScreen(doctorId: doctor.id),
              transition: Transition.rightToLeft,
            );
          },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorClass.blueLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFF8F9FE),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AppUtils.networkImageWidget(doctor.image.toString()),
              ),
            ),
            kWidth(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${doctor.name}',
                    style: TextStyleClass.primaryFont700(20, ColorClass.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  kHeight(10),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 15),
                      kWidth(5),
                      Expanded(
                        child: Text(
                          doctor.location.isNotEmpty
                              ? doctor.location
                              : 'Location not specified',
                          style: TextStyleClass.primaryFont300(
                            14,
                            ColorClass.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  kHeight(5),
                  Row(
                    children: [
                      const Icon(Icons.timer_sharp, size: 15),
                      kWidth(5),
                      Expanded(
                        child: Text(
                          doctor.time.isNotEmpty
                              ? doctor.time
                              : 'Time not specified',
                          style: TextStyleClass.primaryFont300(
                            14,
                            ColorClass.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  kHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: ColorClass().getDepartmentColor(
                              doctor.department,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            doctor.department.isNotEmpty
                                ? doctor.department.toUpperCase()
                                : 'GENERAL',
                            style: TextStyleClass.primaryFont600(
                              12,
                              ColorClass.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      kWidth(8),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ColorClass.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            doctor.gender.isNotEmpty ? doctor.gender : 'N/A',
                            style: TextStyleClass.primaryFont500(
                              10,
                              ColorClass.textBlack,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
