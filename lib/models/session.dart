// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Session {
  final String? start;
  final String? end;
  final String? day;
  final DateTime? date;
  final String? formationTitle;
  final String? group;
  final String? teache;
  Session({
    this.start,
    this.end,
    this.day,
    this.date,
    this.formationTitle,
    this.group,
    this.teache,
  });

  Session copyWith({
    String? start,
    String? end,
    String? day,
    DateTime? date,
    String? formationTitle,
    String? group,
    String? teache,
  }) {
    return Session(
      start: start ?? this.start,
      end: end ?? this.end,
      day: day ?? this.day,
      date: date ?? this.date,
      formationTitle: formationTitle ?? this.formationTitle,
      group: group ?? this.group,
      teache: teache ?? this.teache,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'start': start,
      'end': end,
      'day': day,
      'date': date?.millisecondsSinceEpoch,
      'formationTitle': formationTitle,
      'group': group,
      'teache': teache,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      start: map['start'],
      end: map['end'],
      day: map['day'],
      date: DateTime.parse(map['date']),
      formationTitle: map['formation']['title'],
      group: map['group']['name'],
      teache: map['group']['teacher']['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Session(start: $start, end: $end, day: $day, date: $date, formationTitle: $formationTitle, group: $group, teache: $teache)';
  }

  @override
  bool operator ==(covariant Session other) {
    if (identical(this, other)) return true;

    return other.start == start &&
        other.end == end &&
        other.day == day &&
        other.date == date &&
        other.formationTitle == formationTitle &&
        other.group == group &&
        other.teache == teache;
  }

  @override
  int get hashCode {
    return start.hashCode ^
        end.hashCode ^
        day.hashCode ^
        date.hashCode ^
        formationTitle.hashCode ^
        group.hashCode ^
        teache.hashCode;
  }
}
