import 'package:doctor_finder_app/core/constants/color_class.dart';
import 'package:doctor_finder_app/core/utils/app_utils.dart';
import 'package:doctor_finder_app/getx_controller/pdf_generator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtonsWidget extends StatelessWidget {
  final Function()? onBookAppointment;
  final String bookingButtonText;
  final Color bookingButtonColor;
  final IconData bookingIcon;

  const ActionButtonsWidget({
    Key? key,
    this.onBookAppointment,
    this.bookingButtonText = 'Generate PDF',
    this.bookingButtonColor = ColorClass.primaryColor,
    this.bookingIcon = Icons.picture_as_pdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Get.find() since the controller is already initialized in the parent screen
    final PdfGeneratorController pdfController =
        Get.find<PdfGeneratorController>();

    return Obx(() {
      final isGenerating = pdfController.isGeneratingPdf.value;

      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: bookingButtonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: isGenerating ? null : onBookAppointment,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isGenerating)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: AppUtils.loadingWidget(context, 50),
                  )
                else
                  Icon(bookingIcon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  isGenerating ? 'Generating...' : bookingButtonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
