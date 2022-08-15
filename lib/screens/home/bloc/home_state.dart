part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeDataLoadingState extends HomeState {}

class HomeDataLoadedState extends HomeState {
  final List<Result> topRatedMovies;
  final List<Result> popularMovies;
  final List<Result> nowPlayingMovies;
  const HomeDataLoadedState({
    required this.topRatedMovies,
    required this.popularMovies,
    required this.nowPlayingMovies,
  });
}
