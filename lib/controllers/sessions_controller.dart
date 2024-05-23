import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/models/session.dart';
import 'package:library_app/utils/consts.dart';
import 'package:http/http.dart' as http;

class SessionsController extends ChangeNotifier {
  List<Session> sessions = [];

  Future<List<Session>> getSessions(String week) async {
    sessions.clear();
    try {
      final responce = await http.get(
        Uri.parse("$baseUrl/sessions"),
        headers: {"Authorization": "Bearer $token"},
      );
      final decodedResponce = jsonDecode(responce.body);
      final List ses = decodedResponce[week];
      for (var element in ses) {
        Session session = Session.fromMap(element);
        sessions.add(session);
      }
    } catch (e) {}
    return sessions;
  }
}
