import 'dart:convert';

class ReportFileModel {
  final String name;
  final String date;
  final String time;
  final String size;
  final String filePath;
  final String fileType;
  final String url;
  final String path;
  final String report;
  final String reporterName;
  final String reporterEmail;
  final String documentId;

  ReportFileModel({
    required this.name,
    required this.date,
    required this.time,
    required this.size,
    required this.filePath,
    required this.fileType,
    required this.url,
    required this.reporterEmail,
    required this.reporterName,
    this.path = "",
    required this.report,
    required this.documentId,
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
      'path': path,
      'report': report,
      'reporterName': reporterName,
      'reporterEmail': reporterEmail,
      'documentId': documentId,
    };
  }

  factory ReportFileModel.fromMap(Map<String, dynamic> map) {
    return ReportFileModel(
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      size: map['size'] ?? '',
      filePath: map['filePath'] ?? '',
      fileType: map['fileType'] ?? '',
      url: map['url'] ?? '',
      path: map['path'] ?? '',
      report: map['report'] ?? '',
      reporterName: map['reporterName'] ?? '',
      reporterEmail: map['reporterEmail'] ?? '',
      documentId: map['documentId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportFileModel.fromJson(String source) =>
      ReportFileModel.fromMap(json.decode(source));

  ReportFileModel copyWith({
    String? name,
    String? date,
    String? time,
    String? size,
    String? filePath,
    String? fileType,
    String? url,
    String? path,
    String? report,
    String? documentId,
    String? reporterEmail,
    String? reporterName,
  }) {
    return ReportFileModel(
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      size: size ?? this.size,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      url: url ?? this.url,
      path: path ?? this.path,
      report: report ?? this.report,
      documentId: documentId ?? this.documentId,
      reporterEmail: reporterEmail ?? this.reporterEmail,
      reporterName: reporterName ?? this.reporterName,
    );
  }

  @override
  String toString() {
    return 'ReportFileModel(name: $name, date: $date, time: $time, size: $size, filePath: $filePath, fileType: $fileType, url: $url, path: $path, report: $report)';
  }
}
