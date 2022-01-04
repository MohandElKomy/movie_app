import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/model/movies.dart';
import 'package:movie_app/data/network/api_service.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading()) {
    on<MovieEventStarted>((event, emit) async* {
      yield _mapMovieEventStateToState(event.movieId, event.query, emit);
    });
  }
  // @override
  // Stream<MovieState> mapEventToState(MovieEvent event) async* {
  //   if (event is MovieEventStarted) {
  //     yield* _mapMovieEventStateToState(event.movieId, event.query);
  //   }
  // }

  Stream<MovieState> _mapMovieEventStateToState(
      int? movieId, String? query, Emitter<MovieState> emit) async* {
    final service = ApiService();
    emit(MovieLoading());
    try {
      List<Results> movieList;
      if (movieId == 0) {
        movieList = await service.getNowPlayingMovie();
      } else {
        print(movieId);
        movieList = await service.getMovieByGenre(movieId!);
      }

      emit(MovieLoaded(movieList!));
    } on Exception catch (e) {
      print(e);
      emit(MovieError());
    }
  }
}
