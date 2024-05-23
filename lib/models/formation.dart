import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Formation {
  final int? id;
  final int? sort;
  final String? title;
  final String? image;
  final String? description;
  final int? price;
  final String? progress;
  final String? status;
  final int? period;
  final String? units;
  final List<Diplome> additionalDiplomas;
  final String? domain;
  final Map<String, dynamic>? course;

  Formation({
    this.id,
    this.sort,
    this.title,
    this.image,
    this.description,
    this.price,
    this.status,
    this.period,
    this.progress,
    this.units,
    this.additionalDiplomas = const [],
    this.domain,
    this.course,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'description': description,
      'price': price,
      'periode': period,
      'units': units,
      'additional_diplomas': additionalDiplomas,
      'progress': progress,
      'domain': domain,
      'sort': sort,
      'status': status,
    };
  }

  factory Formation.fromMap(Map<String, dynamic> map) {
    // try {
    return Formation(
      id: map['id'] != null ? map['id'] as int : null,
      sort: map['sort'] != null ? map['sort'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      image: map['image'] != null ? map['image'] as String : "",
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] ?? 0.0,
      status: map['status'] != null ? map['status'] as String : null,
      period: map['periode'],
      progress: map['progress'] ?? "0",
      units: map['units'] != null ? map['units'] as String : null,
      additionalDiplomas: map['additional_diplomas'] != null
          ? List.generate(
              map['additional_diplomas'].length,
              (index) => Diplome.fromMap(
                map['additional_diplomas'][index],
              ),
            )
          : [],
      domain: map['domain'] == null
          ? "Domaine"
          : map['domain']['title'] != null
              ? map['domain']['title'] as String
              : null,
      course: map['current_course'],
    );
    // } catch (e) {
    // return Formation(
    //   id: map['id'] != null ? map['id'] as int : null,
    //   sort: map['sort'] != null ? map['sort'] as int : null,
    //   title: map['title'] != null ? map['title'] as String : null,
    //   image: map['image'] != null ? map['image'] as String : null,
    //   description:
    //       map['description'] != null ? map['description'] as String : null,
    //   price: map['price'],
    //   progress: map['progress'] != null ? int.parse(map['progress']) : 0,
    //   status: map['status'] != null ? map['status'] as bool : null,
    //   period: map['periode'],
    //   units: map['units'] != null ? map['units'] as String : null,
    //   additionalDiplomas: map['additional_diplomas'] != null
    //       ? List.generate(
    //           map['additional_diplomas'].length,
    //           (index) => Diplome.fromMap(
    //             map['additional_diplomas'][index],
    //           ),
    //         )
    //       : [],
    //   domain: map['domain'] == null
    //       ? "Domaine"
    //       : map['domain'] != null
    //           ? map['domain'] as String
    //           : null,
    // );
    // }
  }

  String toJson() => json.encode(toMap());

  factory Formation.fromJson(String source) =>
      Formation.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Diplome {
  final String? diploma;
  final String? price;
  Diplome({
    this.diploma,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'diploma': diploma,
      'price': price,
    };
  }

  factory Diplome.fromMap(Map<String, dynamic> map) {
    return Diplome(
      diploma: map['diploma'] != null ? map['diploma'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Diplome.fromJson(String source) =>
      Diplome.fromMap(json.decode(source) as Map<String, dynamic>);
}
