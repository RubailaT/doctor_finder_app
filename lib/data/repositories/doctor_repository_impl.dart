import 'package:doctor_finder_app/data/data_sources/doctor_remote_data_sources.dart';
import 'package:doctor_finder_app/domain/entities/respositpries/doctor_reo.dart';
import 'package:get/get.dart';
import '../../domain/entities/doctor.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource _remoteDataSource =
      Get.find<DoctorRemoteDataSource>();

  @override
  Future<List<Doctor>> getDoctors() async {
    return await _remoteDataSource.getDoctors();
  }

  @override
  Future<Doctor> getDoctorById(String id) async {
    return await _remoteDataSource.getDoctorById(id);
  }
}
