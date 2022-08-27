import 'package:note_sharing_project/models/subject.dart';

String getPathFromSubject(Subject subject) {
  return "${subject.program}-${subject.semester}-${subject.name}";
}
