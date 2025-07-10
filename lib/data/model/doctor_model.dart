import '../../domain/entities/doctor.dart';

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
