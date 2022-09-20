enum FileType { image, pdf }

FileType? getFileType(String value) {
  if (value == "jpg" || value == "png" || value == "jpeg") {
    return FileType.image;
  }
  if (value == "pdf") {
    return FileType.pdf;
  }
  return null;
}
