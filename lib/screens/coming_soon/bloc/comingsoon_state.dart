part of 'comingsoon_bloc.dart';

abstract class ComingsoonState {
  const ComingsoonState();
}

class UpcomingMoviesLoadingState extends ComingsoonState {}

class UpcomingMoviesLoadedState extends ComingsoonState {
  final List<Result> movies;
  const UpcomingMoviesLoadedState(this.movies);
}

class LoadGenresState extends ComingsoonState {
  final List<Genre> genres;
  const LoadGenresState(this.genres);
}
