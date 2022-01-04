part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Results>? movieList;
  const MovieLoaded(this.movieList);
  @override
  List<Object> get props => [];
}

class MovieError extends MovieState {}
