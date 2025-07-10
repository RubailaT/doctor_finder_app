import 'package:doctor_finder_app/data/repositories/doctor_repository_impl.dart';
import 'package:doctor_finder_app/domain/entities/respositpries/doctor_reo.dart';
import 'package:get/get.dart';
import '../entities/doctor.dart';

class GetDoctorsUseCase {
  final DoctorRepository _repository = Get.find<DoctorRepositoryImpl>();

  Future<List<Doctor>> call() async {
    return await _repository.getDoctors();
  }
}
