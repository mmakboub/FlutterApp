import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/models/workshop.dart';
import 'package:library_app/utils/consts.dart';

class WorkshopsController extends ChangeNotifier {
  List<Workshop> workshops = [];

  Future<List<Workshop>> getWorkshops() async {
    workshops.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/workshops"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Workshop workshop = Workshop.fromMap(element);
      workshops.add(workshop);
    }
    return workshops;
  }
}
