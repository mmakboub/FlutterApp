import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/models/user.dart';
import "../utils/consts.dart";

  late User user;
class LoginController extends ChangeNotifier {
  Future<bool> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {"email": "student@mail.com", "password": "123456789"},

      // {"email": email, "password": password},
    );
    print(response.body);

    final decodedResponce = jsonDecode(response.body);

    user = User.fromMap(decodedResponce["user"]);
    token = decodedResponce["token"];
    return decodedResponce["token"] != null;
  }
}
