import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/models/offer.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/utils/consts.dart';

class OffersController extends ChangeNotifier {
  String selectedParam = "job";

  void selectParam(String param) {
    selectedParam = param;
    notifyListeners();
  }

  Future<List<Offer>> getOffers() async {
    List<Offer> offers = [];
    final responce = await http.get(
      Uri.parse("$baseUrl/offers?type=$selectedParam"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    print(decodedResponce);
    for (var element in decodedResponce) {
      Offer workshop = Offer.fromMap(element);
      offers.add(workshop);
    }
    return offers;
  }

  Future<List<Offer>> getFavoritesOffers() async {
    List<Offer> offers = [];
    final responce = await http.get(
      Uri.parse("$baseUrl/user/favorites"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    print(decodedResponce);
    for (var element in decodedResponce) {
      Offer workshop = Offer.fromMap(element);
      offers.add(workshop);
    }
    return offers;
  }

  void addToFavorites(int offerId) async {
    final responce = await http.post(
      Uri.parse("$baseUrl/offers/$offerId/favorites"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    print(decodedResponce);
  }

  void deleteFromFavorites(int offerId) async {
    final responce = await http.delete(
      Uri.parse("$baseUrl/offers/$offerId/favorites"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    print(decodedResponce);
  }
}
