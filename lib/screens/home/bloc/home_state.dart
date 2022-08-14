part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeDataLoadingState extends HomeState {}

class HomeDataLoadedState extends HomeState {
  final List<Result> trendingMovies;
  final List<Result> discoverMovies;
  final List<Result> upcomingMovies;
  const HomeDataLoadedState({
    required this.trendingMovies,
    required this.discoverMovies,
    required this.upcomingMovies,
  });
}
