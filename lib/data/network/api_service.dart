import 'package:dio/dio.dart';
import 'package:movie_app/data/model/movie.dart';
import 'dart:convert';

import 'package:movie_app/data/model/movies.dart';

class ApiService {
  final _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=39fd4154da1c6c686b478080de462077';

  Future<List<Results>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/now_playing?$apiKey';
      final response = await _dio.get(url);
      var movies = Movies.fromJson(response.data);
      // List<Movie> movieList = (movies["results"] as List)
      //     .map((json) => new Movie.fromJson(json))
      //     .toList();
      List<Results>? movieList = movies.results;

      print(movieList);
      return movieList!;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception occurred: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Results>> getMovieByGenre(int movieId) async {
    try {
      final url = '$baseUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await _dio.get(url);
      var movies = Movies.fromJson(response.data);
      List<Results>? movieList = movies.results;

      return movieList!;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
