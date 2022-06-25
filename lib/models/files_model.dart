import 'dart:convert';

class FileModel {
  final String name;
  final String date;
  final String time;
  final String size;
  final String filePath;
  final String fileType;
  FileModel({
    required this.name,
    required this.date,
    required this.time,
    required this.size,
    required this.filePath,
    required this.fileType,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'size': size,
      'filePath': filePath,
      'fileType': fileType,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      size: map['size'] ?? '',
      filePath: map['filePath'] ?? '',
      fileType: map['fileType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModel.fromJson(String source) =>
      FileModel.fromMap(json.decode(source));
}

List<FileModel> dummyFileList = [
  FileModel(
      fileType: "image/jpeg",
      filePath: "docs/bts2.jpeg",
      name: "bts2.jpeg",
      date: "10 Dec 2022",
      time: "1:30 PM",
      size: "1.7 MB"),
  FileModel(
      fileType: "image/jpeg",
      filePath: "docs/twice.png",
      name: "twice.jpeg",
      date: "10 Nov 2022",
      time: "12:30 PM",
      size: "7.9 MB"),
  FileModel(
      fileType: "image/jpeg",
      filePath: "/docs/bts4.jpeg",
      name: "bts4.jpeg",
      date: "10 Dec 2022",
      time: "1:30 PM",
      size: "1.7 MB"),
  FileModel(
      fileType: "image/jpeg",
      filePath: "docs/ApplicationDetails.pdf",
      name: "ApplicationDetails.pdf",
      date: "10 Nov 2022",
      time: "12:30 PM",
      size: "7.9 MB"),
];
