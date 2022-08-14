part of 'home_bloc.dart';

abstract class HomeEvent  {
  const HomeEvent();
}

class LoadTrendingMoviesEvent extends HomeEvent {
  final url = trendingUrl;
 
}

class LoadDiscoverMoviesEvent extends HomeEvent {
  final url = discoverUrl;
 
}
