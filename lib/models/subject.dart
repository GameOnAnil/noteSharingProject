import 'dart:convert';

class Subject {
  final int? id;
  final String name;
  final String semester;
  final String program;
  Subject({
    this.id,
    required this.name,
    required this.semester,
    required this.program,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'semester': semester,
      'program': program,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      semester: map['semester'] ?? '',
      program: map['program'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source));
}
