part of 'home_bloc.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class MainPosterLoadingState extends HomeState {}

class MainPosterLoadedState extends HomeState {
  final List<Result> movies;
  const MainPosterLoadedState(this.movies);
}

class HomeListLoadingState extends HomeState {}

class HomeListLoadedState extends HomeState {
  final List<Result> movies;
  const HomeListLoadedState(this.movies);
}
