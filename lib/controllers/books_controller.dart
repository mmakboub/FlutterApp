import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/utils/consts.dart';

class BooksController extends ChangeNotifier {
  List<Book> books = [];

  Future<List<Book>> getBooks() async {
    books.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/books"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Book book = Book.fromMap(element);
      books.add(book);
    }
    return books;
  }

  Future<List<Book>> searchBooks(String name) async {
    books.clear();
    final responce = await http.get(
      Uri.parse("$baseUrl/books/search/$name"),
      headers: {"Authorization": "Bearer $token"},
    );
    final List decodedResponce = jsonDecode(responce.body);
    for (var element in decodedResponce) {
      Book book = Book.fromMap(element);
      books.add(book);
    }
    return books;
  }

  Future<List<Book>> showBooks(String name) async {
    if (name.isEmpty) {
      books = await getBooks();
    } else {
      books = await searchBooks(name);
    }
    return books;
  }
}
