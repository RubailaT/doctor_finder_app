import 'package:doctor_finder_app/core/netwrok/network_service.dart';
import 'package:doctor_finder_app/data/model/doctor_model.dart';
import 'package:doctor_finder_app/domain/entities/doctor.dart';
import 'package:get/get.dart';

class DoctorRemoteDataSource {
  final NetworkService _networkService = Get.find<NetworkService>();

  Future<List<DoctorModel>> getDoctors() async {
    try {
      final List<dynamic> response = await _networkService.getList('/doctors');
      return response.map((json) => DoctorModel.fromJson(json)).toList();
    } catch (e) {
      // Return mock data if API fails for demo purposes
      return _getMockDoctors();
    }
  }

  Future<DoctorModel> getDoctorById(String id) async {
    try {
      final Map<String, dynamic> response = await _networkService.get(
        '/doctors/$id',
      );
      return DoctorModel.fromJson(response);
    } catch (e) {
      // Return mock data if API fails for demo purposes
      final mockDoctors = _getMockDoctors();
      return mockDoctors.firstWhere(
        (doctor) => doctor.id == id,
        orElse: () => mockDoctors.first,
      );
    }
  }

  List<DoctorModel> _getMockDoctors() {
    return [
      const DoctorModel(
        id: '1',
        name: 'Arnold Herzog',
        image: 'https://avatars.githubusercontent.com/u/40674148',
        gender: 'Male',
        time: '10:00am - 04:00pm',
        location: 'Kottayam',
        department: 'Pediatrics',
      ),
      const DoctorModel(
        id: '2',
        name: 'Henrietta Dietrich',
        image: 'https://avatars.githubusercontent.com/u/40674148',
        gender: 'Female',
        time: '09:00am - 01:00pm',
        location: 'Ernakulam',
        department: 'Cardiology',
      ),
      const DoctorModel(
        id: '3',
        name: 'Tasha Buckridge-Barrows',
        image: 'https://avatars.githubusercontent.com/u/58711623',
        gender: 'Female',
        time: '01:00pm - 05:00pm',
        location: 'Kozhikode',
        department: 'Dermatology',
      ),
      const DoctorModel(
        id: '4',
        name: 'Flora Reichel',
        image: 'https://avatars.githubusercontent.com/u/16270484',
        gender: 'Female',
        time: '10:30am - 03:30pm',
        location: 'Thiruvananthapuram',
        department: 'Neurology',
      ),
      const DoctorModel(
        id: '5',
        name: 'Camille Bayer',
        image: 'https://avatars.githubusercontent.com/u/91633616',
        gender: 'Non-binary',
        time: '11:00am - 04:00pm',
        location: 'Kannur',
        department: 'Orthopedics',
      ),
      const DoctorModel(
        id: '6',
        name: 'Penny Cronin',
        image: 'https://avatars.githubusercontent.com/u/91633616',
        gender: 'Female',
        time: '08:00am - 12:00pm',
        location: 'Thrissur',
        department: 'ENT',
      ),
      const DoctorModel(
        id: '7',
        name: 'Alicia Langworth',
        image: 'https://avatars.githubusercontent.com/u/6179754',
        gender: 'Non-binary',
        time: '02:00pm - 06:00pm',
        location: 'Palakkad',
        department: 'Gynecology',
      ),
      const DoctorModel(
        id: '8',
        name: 'Melvin Emard',
        image: 'https://avatars.githubusercontent.com/u/91633616',
        gender: 'Male',
        time: '12:00pm - 04:00pm',
        location: 'Pathanamthitta',
        department: 'Urology',
      ),
      const DoctorModel(
        id: '9',
        name: 'Jack Klocko',
        image: 'https://avatars.githubusercontent.com/u/94480742',
        gender: 'Male',
        time: '11:30am - 03:30pm',
        location: 'Idukki',
        department: 'Radiology',
      ),
      const DoctorModel(
        id: '10',
        name: 'Gerald Treutel',
        image: 'https://avatars.githubusercontent.com/u/91633616',
        gender: 'Male',
        time: '01:30pm - 05:30pm',
        location: 'Malappuram',
        department: 'General Medicine',
      ),
      const DoctorModel(
        id: '11',
        name: 'Clark O\'Keefe',
        image: 'https://avatars.githubusercontent.com/u/82608907',
        gender: 'Male',
        time: '10:00am - 02:00pm',
        location: 'Alappuzha',
        department: 'Psychiatry',
      ),
    ];
  }
}

// Also update your DoctorModel class to match the API structure:

class DoctorModel extends Doctor {
  const DoctorModel({
    required String id,
    required String name,
    required String image,
    required String gender,
    required String time,
    required String location,
    required String department,
  }) : super(
         id: id,
         name: name,
         image: image,
         gender: gender,
         time: time,
         location: location,
         department: department,
       );

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'gender': gender,
      'time': time,
      'location': location,
      'department': department,
    };
  }
}
