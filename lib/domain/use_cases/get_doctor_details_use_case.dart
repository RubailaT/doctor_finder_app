import 'package:doctor_finder_app/data/repositories/doctor_repository_impl.dart';
import 'package:doctor_finder_app/domain/entities/respositpries/doctor_reo.dart';
import 'package:get/get.dart';
import '../entities/doctor.dart';

class GetDoctorDetailsUseCase {
  final DoctorRepository _repository = Get.find<DoctorRepositoryImpl>();

  Future<Doctor> call(String id) async {
    return await _repository.getDoctorById(id);
  }
}
