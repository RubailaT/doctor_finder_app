import 'dart:convert';
import 'dart:io';
import 'package:doctor_finder_app/core/constants/api_urls.dart';
import 'package:doctor_finder_app/core/errors/errors_failure.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.getDoctorsData()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerFailure('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw NetworkFailure('No internet connection');
    } catch (e) {
      throw ServerFailure('Unexpected error: $e');
    }
  }

  Future<List<dynamic>> getList(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.getDoctorsData()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw ServerFailure('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw NetworkFailure('No internet connection');
    } catch (e) {
      throw ServerFailure('Unexpected error: $e');
    }
  }
}
