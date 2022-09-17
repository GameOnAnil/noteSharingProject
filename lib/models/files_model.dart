import 'dart:developer';

class FileModel {
  final String name;
  final String date;
  final String time;
  final String size;
  final String filePath;
  final String fileType;
  final String url;
  final String documentId;
  final String uploaderId;

  FileModel({
    required this.name,
    required this.date,
    required this.time,
    required this.size,
    required this.filePath,
    required this.fileType,
    required this.url,
    this.documentId = "",
    required this.uploaderId,
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
      'documentId': documentId,
      'uploaderId': uploaderId,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map, String documentId) {
    log("docid$documentId");
    return FileModel(
        name: map['name'] ?? '',
        date: map['date'] ?? '',
        time: map['time'] ?? '',
        size: map['size'] ?? '',
        filePath: map['filePath'] ?? '',
        fileType: map['fileType'] ?? '',
        url: map['url'] ?? '',
        documentId: documentId,
        uploaderId: map['uploaderId'] ?? '');
  }

  FileModel copyWith(
      {String? name,
      String? date,
      String? time,
      String? size,
      String? filePath,
      String? fileType,
      String? url,
      String? path,
      String? documentId,
      String? uploaderId}) {
    return FileModel(
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      size: size ?? this.size,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      url: url ?? this.url,
      documentId: documentId ?? this.documentId,
      uploaderId: uploaderId ?? this.uploaderId,
    );
  }

  @override
  String toString() {
    return 'FileModel(name: $name, date: $date, time: $time, size: $size, filePath: $filePath, fileType: $fileType, url: $url, documentId: $documentId, uploaderId: $uploaderId)';
  }
}
