import 'dart:convert';

class FileModel {
  final String name;
  final String date;
  final String time;
  final String size;
  final String filePath;
  final String fileType;
  final String url;
  FileModel({
    required this.name,
    required this.date,
    required this.time,
    required this.size,
    required this.filePath,
    required this.fileType,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'size': size,
      'filePath': filePath,
      'fileType': fileType,
      'url': url,
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
      url: map['url'] ?? '',
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
    size: "1.7 MB",
    url:
        "https://firebasestorage.googleapis.com/v0/b/notesharingapp-1ef6f.appspot.com/o/docs%2Fbts2.jpeg?alt=media&token=9ab7171f-5344-4b2e-af41-7b7c78d680fa",
  ),
  FileModel(
    fileType: "image/jpeg",
    filePath: "docs/twice.png",
    name: "twice.jpeg",
    date: "10 Nov 2022",
    time: "12:30 PM",
    size: "7.9 MB",
    url:
        "https://firebasestorage.googleapis.com/v0/b/notesharingapp-1ef6f.appspot.com/o/docs%2Ftwice.png?alt=media&token=fd2c26de-157b-4612-94de-7e06e92d1577",
  ),
  FileModel(
    fileType: "video/mp4",
    filePath: "docs/myRecording.mp4",
    name: "myRecording.mp4",
    date: "10 Dec 2022",
    time: "1:30 PM",
    size: "1.7 MB",
    url:
        "https://firebasestorage.googleapis.com/v0/b/notesharingapp-1ef6f.appspot.com/o/docs%2FmyRecording.mp4?alt=media&token=d2ded35d-9faf-42bd-b3bc-9f8b8613395e",
  ),
  FileModel(
    fileType: "video/mp4",
    filePath: "docs/myvideo.mp4",
    name: "myvideo.mp4",
    date: "10 Dec 2022",
    time: "1:30 PM",
    size: "30.7 MB",
    url:
        "https://firebasestorage.googleapis.com/v0/b/notesharingapp-1ef6f.appspot.com/o/docs%2Fmyvideo.mp4?alt=media&token=bd5ec262-1255-43b9-86bc-ea668e886398",
  ),
  FileModel(
    fileType: "application/pdf",
    filePath: "docs/ApplicationDetails.pdf",
    name: "ApplicationDetails.pdf",
    date: "10 Nov 2022",
    time: "12:30 PM",
    size: "7.9 MB",
    url:
        "https://firebasestorage.googleapis.com/v0/b/notesharingapp-1ef6f.appspot.com/o/docs%2FApplicationDetails.pdf?alt=media&token=da409ec5-3076-4fac-8a55-97b5908e0e15",
  ),
];
