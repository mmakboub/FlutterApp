import 'dart:convert';
import 'dart:ffi';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final String? body;
  final DateTime? createAt;
  final String? username;
  final String? userimage;
  final int? userid;
  Message({
    required this.body,
    required this.createAt,
    required this.username,
    required this.userimage,
    required this.userid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'createAt': createAt?.millisecondsSinceEpoch,
      'username': username,
      'userid': username,
      'userimage': userimage,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      body: map['body'] != null ? map['body'] as String : null,
      createAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      username:
          map['user']['name'] != null ? map['user']['name'] as String : null,
      userimage:
          map['user']['image'] != null ? map['user']['image'] as String : null,
      userid: map['user_id'] != null ? map['user_id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
