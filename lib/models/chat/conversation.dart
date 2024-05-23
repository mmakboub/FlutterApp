import 'dart:convert';

class Conversation {
  Conversation({
    this.id,
    this.name,
    this.image,
    this.teacher,
    this.updatedAt,
    this.formation,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? teacher;
  final DateTime? updatedAt;
  final String? formation;

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id'] != null ? map['id'] as int : null,
      name:
          map['group']['name'] != null ? map['group']['name'] as String : null,
      image: map['group']['formation']['image'] != null
          ? map['group']['formation']['image'] as String
          : null,
      teacher: map['group']['teacher']['name'] != null
          ? map['group']['teacher']['name'] as String
          : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      formation:
          map['group']['name'] != null ? map['group']['name'] as String : null,
    );
  }

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);
}
