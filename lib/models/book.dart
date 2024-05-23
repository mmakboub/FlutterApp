import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Book {
  final int? id;
  final String? title;
  final String? pdf;
  final String? image;
  final String? author;
  final String? domain;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Book({
    this.id,
    this.title,
    this.pdf,
    this.image,
    this.author,
    this.domain,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'pdf': pdf,
      'image': image,
      'author': author,
      'domain': domain,
      'status': status,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      pdf: map['pdf'] != null ? map['pdf'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      domain: map['domain'] != null ? map['domain'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source) as Map<String, dynamic>);
}
