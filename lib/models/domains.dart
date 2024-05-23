// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Domain {
  final int? id;
  final int? sort;
  final String? title;
  final String? description;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Domain({
    this.id,
    this.sort,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sort': sort,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory Domain.fromMap(Map<String, dynamic> map) {
    return Domain(
      id: map['id'] != null ? map['id'] as int : null,
      sort: map['sort'] != null ? map['sort'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as bool : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Domain.fromJson(String source) =>
      Domain.fromMap(json.decode(source) as Map<String, dynamic>);
}
