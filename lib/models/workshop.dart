import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Workshop {
  final int? id;
  final String? title;
  final DateTime? beginDate;
  final DateTime? endDate;
  final String? description;
  final String? image;
  final String? participants;
  final double? price;
  final String? address;
  final String? about;
  final String? link;
  final String? video;
  final DateTime? publishDate;
  final bool? status;
  final int? participants_count;
  final bool? isFree;

  Workshop({
    this.id,
    this.title,
    this.beginDate,
    this.endDate,
    this.description,
    this.image,
    this.participants,
    this.price,
    this.address,
    this.about,
    this.link,
    this.video,
    this.publishDate,
    this.status,
    this.participants_count,
    this.isFree,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date_from': beginDate?.millisecondsSinceEpoch,
      'date_to': endDate?.millisecondsSinceEpoch,
      'description': description,
      'image': image,
      'participants': participants,
      'price': price,
      'address': address,
      'about': about,
      'link': link,
      'video': video,
      'published_at': publishDate?.millisecondsSinceEpoch,
      'active': status! ? 1 : 0,
      'participants_count': participants_count,
      'free': isFree,
    };
  }

  factory Workshop.fromMap(Map<String, dynamic> map) {
    return Workshop(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      beginDate:
          map['date_from'] != null ? DateTime.parse(map['date_from']) : null,
      endDate: map['date_to'] != null ? DateTime.parse(map['date_to']) : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      participants:
          map['participants'] != null ? map['participants'] as String : null,
      price: map['price'] != null ? double.parse(map['price']) : null,
      address: map['address'] != null ? map['address'] as String : null,
      about: map['about'] != null ? map['about'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      video: map['video'] != null ? map['video'] as String : null,
      publishDate: map['published_at'] != null
          ? DateTime.parse(map['published_at'])
          : null,
      status: map['active'] != null
          ? map['active'] == 1
              ? true
              : false
          : null,
      participants_count: map['participants_count'] != null
          ? map['participants_count'] as int
          : null,
      isFree: map['free'] != null ? map['free'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Workshop.fromJson(String source) =>
      Workshop.fromMap(json.decode(source) as Map<String, dynamic>);
}
