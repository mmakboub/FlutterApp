import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/models/chat/conversation.dart';
import 'package:library_app/utils/consts.dart';

class ChatController extends ChangeNotifier {
  List<Conversation> conversations = [];

  Future<List<Conversation>> getConversations() async {
    conversations.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/conversations"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Conversation conversation = Conversation.fromMap(element);
      conversations.add(conversation);
    }
    return conversations;
  }
}
