// To parse this JSON data, do
//
//     final doctorDataModel = doctorDataModelFromJson(jsonString);

import 'dart:convert';

String doctorDataModelToJson(List<DoctorDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorDataModel {
  String id;
  String name;
  String image;
  String gender;
  String time;
  String location;
  String department;

  DoctorDataModel({
    required this.id,
    required this.name,
    required this.image,
    required this.gender,
    required this.time,
    required this.location,
    required this.department,
  });

  factory DoctorDataModel.fromJson(Map<String, dynamic> json) {
    return DoctorDataModel(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      image: json["image"]?.toString() ?? "",
      gender: json["gender"]?.toString() ?? "",
      time: _parseTime(json["time"]?.toString() ?? ""),
      location: json["location"]?.toString() ?? "",
      department: _parseDepartment(json["department"]?.toString() ?? ""),
    );
  }

  // Handle different time formats
  static String _parseTime(String timeString) {
    if (timeString.isEmpty) return "";

    // Check if it's an ISO timestamp
    if (timeString.contains('T') && timeString.contains('Z')) {
      try {
        final dateTime = DateTime.parse(timeString);
        final hour = dateTime.hour;
        final minute = dateTime.minute;
        final period = hour >= 12 ? 'pm' : 'am';
        final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
        final minuteStr = minute.toString().padLeft(2, '0');
        return '$displayHour:${minuteStr}$period';
      } catch (e) {
        return timeString; // Return original if parsing fails
      }
    }
    return timeString; // Return as-is for normal format
  }

  // Handle invalid department values
  static String _parseDepartment(String department) {
    if (department.contains('Invalid faker method')) {
      return 'General Medicine';
    }
    return department;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "gender": gender,
    "time": time,
    "location": location,
    "department": department,
  };
}
