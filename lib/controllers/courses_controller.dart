import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:library_app/models/domains.dart';
import 'package:library_app/models/formation.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/screens/formations/formations_screen.dart';
import 'package:library_app/utils/consts.dart';

class CoursesController extends ChangeNotifier {
  List<Map<String, dynamic>> courses = [];

  CoursesController();

  Future<List<Map<String, dynamic>>> loadCourses(int formationId) async {
    courses.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/formations/$formationId/courses"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      courses.add(element);
    }
    return courses;
  }
}
