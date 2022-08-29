import 'package:intl/intl.dart';
import 'package:note_sharing_project/models/subject.dart';

String getPathFromSubject(Subject subject) {
  return "${subject.program}-${subject.semester}-${subject.name}";
}

String getTodaysDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  return formattedDate;
}
