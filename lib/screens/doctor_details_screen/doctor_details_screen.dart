import 'package:doctor_finder_app/components/sizedbox.dart';
import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/utils/app_utils.dart';
import 'package:doctor_finder_app/getx_controller/doctor_details_controller.dart';
import 'package:doctor_finder_app/getx_controller/pdf_generator_controller.dart';
import 'package:doctor_finder_app/screens/doctor_details_screen/widgets/action_widget.dart';
import 'package:doctor_finder_app/screens/doctor_details_screen/widgets/doctor_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String doctorId;
  final DoctorDetailsController controller = Get.put(DoctorDetailsController());
  final PdfGeneratorController pdfController = Get.put(
    PdfGeneratorController(),
  ); // Add this line

  DoctorDetailsScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    controller.loadDoctorDetails(doctorId);

    return Scaffold(
      backgroundColor: ColorClass.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorClass.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorClass.primaryColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return AppUtils.loadingWidget(context, 50);
        }

        if (controller.errorMessage.value != null) {
          return AppUtils.noDataFound("Ooooops", "No Doctors Found", context);
        }

        final doctor = controller.doctor.value!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: 'doctor-${doctor.id}',
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AppUtils.networkImageWidget(
                          doctor.image.toString(),
                        ),
                      ),
                    ),
                  ),
                ),
                kHeight(8),
                Center(
                  child: Text(
                    'Dr. ${doctor.name}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                kHeight(16),
                Text(
                  'Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                kHeight(16),
                DoctorDetailCard(
                  icon: Icons.schedule,
                  label: 'Consulting Time',
                  value: doctor.time,
                  color: ColorClass.primaryColor,
                ),
                DoctorDetailCard(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: doctor.location,
                  color: ColorClass.green,
                ),
                DoctorDetailCard(
                  icon: Icons.medical_services,
                  label: 'Department',
                  value: doctor.department,
                  color: ColorClass.orange,
                ),
                DoctorDetailCard(
                  icon: Icons.person,
                  label: 'Gender',
                  value: controller.getGenderString(),
                  color: ColorClass.purple,
                ),
                kHeight(32),
                // Updated ActionButtonsWidget with onTap function
                ActionButtonsWidget(
                  onBookAppointment: () => _generatePdf(),
                  bookingButtonText: 'Generate PDF',
                  bookingIcon: Icons.picture_as_pdf,
                  bookingButtonColor: ColorClass.primaryColor,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Add this method to handle PDF generation
  void _generatePdf() {
    final doctor = controller.doctor.value;
    if (doctor == null) return;

    pdfController.generateDoctorDetailsPdf(
      doctorName: doctor.name,
      consultingTime: doctor.time,
      location: doctor.location,
      department: doctor.department,
      gender: controller.getGenderString(),
    );
  }
}
