import 'dart:convert';

class Subject {
  final int? id;
  final String name;
  final String semester;
  final String program;
  final bool notificationOn;
  Subject({
    this.id,
    required this.name,
    required this.semester,
    required this.program,
    required this.notificationOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'semester': semester,
      'program': program,
      'notificationOn': notificationOn,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    final notFromDb = map['notificationOn'] as int?;
    bool notificationOn;
    if (notFromDb == null) {
      notificationOn = false;
    } else {
      notificationOn = (notFromDb == 0) ? false : true;
    }
    return Subject(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      semester: map['semester'] ?? '',
      program: map['program'] ?? '',
      notificationOn: notificationOn,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source));

  Subject copyWith({
    int? id,
    String? name,
    String? semester,
    String? program,
    bool? notificationOn,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      semester: semester ?? this.semester,
      program: program ?? this.program,
      notificationOn: notificationOn ?? this.notificationOn,
    );
  }

  @override
  String toString() {
    return 'Subject(id: $id, name: $name, semester: $semester, program: $program, notificationOn: $notificationOn)';
  }
}
