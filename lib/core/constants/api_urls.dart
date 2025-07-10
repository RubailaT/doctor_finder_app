class ApiUrls {
  static const String baseUrl =
      'https://686f534991e85fac42a07d85.mockapi.io/api/v1';

  static String getDoctorsData() {
    return '$baseUrl/test/doctors';
  }

  static String getDoctorDetailsById(String id) {
    return '$baseUrl/test/doctors/$id';
  }
}
