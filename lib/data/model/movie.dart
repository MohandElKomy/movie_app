class Movie {
  final String? backdropPath,
      originalLanguage,
      originalTitle,
      overView,
      posterPath,
      releaseDate,
      title,
      voteAverage,
      error;
  final int? id, voteCount;
  final bool? video;
  final double? popularity;

  Movie({
    this.title,
    this.id,
    this.error,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.overView,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }
    return Movie(
      backdropPath: json['backdrop_path'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overView: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toString(),
      voteCount: json['vote_count'],
    );
  }
}
