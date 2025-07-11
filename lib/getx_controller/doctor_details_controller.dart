import 'package:get/get.dart';
import 'package:doctor_finder_app/getx_controller/doctor_controller.dart';
import 'package:doctor_finder_app/data/model/doctor_model.dart';

class DoctorDetailsController extends GetxController {
  final DoctorController doctorController = Get.find<DoctorController>();

  var doctor = Rxn<DoctorDataModel>();
  var isLoading = true.obs;
  var errorMessage = RxnString();

  // Load doctor details
  Future<void> loadDoctorDetails(String doctorId) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await doctorController.getDoctorDetails(doctorId);
      doctor.value = result;
    } catch (e) {
      errorMessage.value = 'Failed to load doctor details';
    } finally {
      isLoading.value = false;
    }
  }

  // Helper for gender display
  String getGenderString() {
    final value = doctor.value?.gender;
    if (value == null) return '';
    return value.toString().split('.').last;
  }
}
