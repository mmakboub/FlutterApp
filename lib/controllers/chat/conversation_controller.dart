// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/models/chat/conversation.dart';
import 'package:library_app/models/chat/message.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/utils/consts.dart';

class ConvesationController extends ChangeNotifier {
  final Conversation convesation;

  ConvesationController({
    required this.convesation,
  });

  Future<List<Message>> getAllMessages() async {
    messages.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/conversations/${convesation.id}/messages"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Message conversation = Message.fromMap(element);
      messages.add(conversation);
    }
    return messages;
  }

  void sendMessage({required String content}) async {
    final responce = await http.post(
      Uri.parse("$baseUrl/conversations/${convesation.id}/messages"),
      headers: {"Authorization": "Bearer $token"},
      body: {"content": content},
    );
    final List decodedResponce = jsonDecode(responce.body);
    notifyListeners();
  }

  List<Message> messages = [];
}
