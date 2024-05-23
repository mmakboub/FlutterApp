import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int? id;
  final String? name;
  final String? address;
  final String? country;
  final String? image;
  final String? status;
  final DateTime? createAt;
  final DateTime? updatedAt;
  final String? email;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.country,
    required this.image,
    required this.status,
    required this.createAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'country': country,
      'email': email,
      'image': image,
      'status': status,
      'createAt': createAt!.millisecondsSinceEpoch,
      'updatedAt': updatedAt!.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      address: map['address'] as String?,
      country: map['country'] as String?,
      image: map['image'] as String?,
      status: map['status'] as String?,
      createAt: map['createAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, address: $address, country: $country, image: $image, status: $status, createAt: $createAt, updatedAt: $updatedAt)';
  }
}
