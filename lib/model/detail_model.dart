class DetailModel {
  final String title;
  final String sinopsis;
  final String thumbnail;
  final String season;
  final String status;
  final String studio;
  final List<Genres> genre;
  final List<Episodes> episodes;
  DetailModel({
    required this.genre,
    required this.title,
    required this.sinopsis,
    required this.thumbnail,
    required this.season,
    required this.status,
    required this.studio,
    required this.episodes,
  });
}

class Genres {
  final String title;
  Genres(this.title);
}

class Episodes {
  final String url;
  final String title;
  final String dateUpload;
  Episodes({
    required this.url,
    required this.title,
    required this.dateUpload,
  });
}
