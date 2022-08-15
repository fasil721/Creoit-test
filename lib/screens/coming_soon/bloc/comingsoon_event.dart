part of 'comingsoon_bloc.dart';

abstract class ComingsoonEvent {
  const ComingsoonEvent();
}

class LoadUpcomingMoviesEvent extends ComingsoonEvent {}

class LoadGenresEvent extends ComingsoonEvent {}
