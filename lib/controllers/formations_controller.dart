import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:library_app/models/domains.dart';
import 'package:library_app/models/formation.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/screens/formations/formations_screen.dart';
import 'package:library_app/utils/consts.dart';

class FormationsController extends ChangeNotifier {
  List<Formation> formations = [];

  static late int selectedDomain;

  FormationsController();

  void selectDomain(int domainId) {
    selectedDomain = domainId;
    notifyListeners();
  }

  static Future<List<Domain>> loadDomains() async {
    List<Domain> domains = [];

    domains.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/domains"),
      // headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Domain domain = Domain.fromMap(element);
      domains.add(domain);
    }
    return domains;
  }

  Future<List<Formation>> loadFormations() async {
    List<Formation> formations = [];

    formations.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/domains/$selectedDomain/formations"),
      // headers: {"Authorization": "Bearer $token"},
    );
    final decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Formation formation = Formation.fromMap(element);
      formations.add(formation);
    }

    return formations;
  }

  Future<List<Formation>> searchFormations(String name) async {
    formations.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/formations/search/$name"),
      // headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Formation formation = Formation.fromMap(element);
      formations.add(formation);
    }
    return formations;
  }

  Future<bool> subscribeAtFormation(
      int formationId, List<Diplome> diplomas) async {
    final responce = await http.post(
      Uri.parse("$baseUrl/enrollments/pay/manual"),
      headers: {"Authorization": "Bearer $token"},
      body: {
        'formation_id': formationId.toString(),
        'additional_diplomas': List.generate(
          diplomas.length,
          (index) => diplomas[index].toMap(),
        ).toString(),
      },
    );
    final decodedResponce = jsonDecode(responce.body);
    print(decodedResponce);
    if (decodedResponce["message"] == "Enrollment created successfully.") {
      return true;
    }
    return false;
  }
}
