import 'package:doctor_finder_app/domain/entities/doctor.dart';

abstract class DoctorRepository {
  Future<List<Doctor>> getDoctors();
  Future<Doctor> getDoctorById(String id);
}
