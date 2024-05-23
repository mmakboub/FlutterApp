import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:library_app/models/domains.dart';
import 'package:library_app/models/formation.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/utils/consts.dart';

class MyFormationsController extends ChangeNotifier {
  List<Formation> myFormations = [];

  int selectedTab = 0;

  void selectDomain(int domainId) {
    selectedTab = domainId;
    notifyListeners();
  }

  Future<List<Formation>> loadMyFormations() async {
    List<Formation> formations = [];
    formations.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/enrollments"),
      headers: {"Authorization": "Bearer $token"},
    );
    final decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Formation formation = Formation.fromMap(element['formation']);
      formations.add(formation);
    }
    return formations;
  }

  Future<List<Formation>> loadMyFormationsInProgress() async {
    List<Formation> formations = [];
    formations.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/formations/status/in_progress"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Formation formation = Formation.fromMap(element);
      formations.add(formation);
    }
    return formations;
  }

  Future<List<Formation>> loadMyFormationsFinished() async {
    List<Formation> formations = [];
    formations.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/formations/status/finished"),
      headers: {"Authorization": "Bearer $token"},
    );
    final decodedResponce = jsonDecode(responce.body);
    print(decodedResponce);
    for (var element in decodedResponce) {
      Formation formation = Formation.fromMap(element);
      formations.add(formation);
    }
    return formations;
  }
}
