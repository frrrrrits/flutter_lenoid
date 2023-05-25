class DetailModel {
  final String title;
  final String sinopsis;
  final String thumbnail;
  final String season, status, studio;
  final List<Genres> genre;
  DetailModel(
    this.genre,
    this.title,
    this.sinopsis,
    this.thumbnail,
    this.season,
    this.status,
    this.studio,
  );
}

class Genres {
  final String title;
  Genres(this.title);
}
