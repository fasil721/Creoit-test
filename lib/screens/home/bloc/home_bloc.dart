import 'package:bloc/bloc.dart';
import 'package:netflix_clone/datas/constants.dart';
import 'package:netflix_clone/models/movie_models.dart';
import 'package:netflix_clone/services/tmdb_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadMoviesEvent>((event, emit) async {
      emit(HomeDataLoadingState());
      final topRatedMovies =
          await TmdbServices.fetchData(MovieUrlType.topRated);
      final popularMovies = await TmdbServices.fetchData(MovieUrlType.popular);
      final nowPlayingMovies =
          await TmdbServices.fetchData(MovieUrlType.upcoming);
      final isValid = topRatedMovies != null &&
          popularMovies != null &&
          nowPlayingMovies != null;
      if (isValid) {
        emit(
          HomeDataLoadedState(
            topRatedMovies: topRatedMovies,
            popularMovies: popularMovies,
            nowPlayingMovies: nowPlayingMovies,
          ),
        );
      } else {
        emit(HomeInitial());
      }
    });
  }
}
