class DownloadModel {
  final String name;
  final List<DownloadLinks> links;

  DownloadModel(this.name, this.links);
}

class DownloadLinks {
  final String title;
  final String links;
  DownloadLinks(this.title, this.links);
}
