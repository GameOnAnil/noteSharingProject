import 'package:universal_html/html.dart' as html;

class DownloadService {
  void openInNewTap(String url) {
    html.window.open(url, "_blank");
  }
}
