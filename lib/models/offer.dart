import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Offer {
  final int? id;
  final String? title;
  final String? image;
  final String? company;
  final String? city;
  final String? salary;
  final String? type;
  final String? contract;
  final String? nature;
  final String? missions;
  final String? skills;
  final String? experience;
  final int? periode;
  final String? unit;
  final bool? active;
  final DateTime? created_at;
  final DateTime? updated_at;
  final bool? is_favor;
  Offer({
    this.id,
    this.title,
    this.image,
    this.company,
    this.city,
    this.salary,
    this.type,
    this.contract,
    this.nature,
    this.missions,
    this.skills,
    this.experience,
    this.periode,
    this.unit,
    this.active,
    this.created_at,
    this.updated_at,
    this.is_favor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'company': company,
      'city': city,
      'salary': salary,
      'type': type,
      'contract': contract,
      'nature': nature,
      'missions': missions,
      'skills': skills,
      'experience': experience,
      'periode': periode,
      'unit': unit,
      'active': active,
      'created_at': created_at?.millisecondsSinceEpoch,
      'updated_at': updated_at?.millisecondsSinceEpoch,
      'is_favor': is_favor,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'],
      title: map['title'] != null ? map['title'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      company: map['company'] != null ? map['company'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      salary: map['salary'] != null ? map['salary'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      contract: map['contract'] != null ? map['contract'] as String : null,
      nature: map['nature'] != null ? map['nature'] as String : null,
      missions: map['missions'] != null ? map['missions'] as String : null,
      skills: map['skills'] != null ? map['skills'] as String : null,
      experience:
          map['experience'] != null ? map['experience'] as String : null,
      periode: map['periode'],
      unit: map['unit'] != null ? map['unit'] as String : null,
      active: map['active'] ?? false,
      created_at:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updated_at:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      is_favor: map['is_favor'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) =>
      Offer.fromMap(json.decode(source) as Map<String, dynamic>);
}
