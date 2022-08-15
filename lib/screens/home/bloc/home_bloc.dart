import 'package:bloc/bloc.dart';
import 'package:netflix_clone/datas/constants.dart';
import 'package:netflix_clone/models/movie_models.dart';
import 'package:netflix_clone/services/tmdb_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadMoviesEvent>((event, emit) async {
      //triggering the loading event
      emit(HomeDataLoadingState());
      // fetching movies from api by type 
      final topRatedMovies =
          await TmdbServices.fetchData(MovieUrlType.topRated);
      final popularMovies = await TmdbServices.fetchData(MovieUrlType.popular);
      final nowPlayingMovies =
          await TmdbServices.fetchData(MovieUrlType.upcoming);
      //checking fetched datas are not null
      final isValid = topRatedMovies != null &&
          popularMovies != null &&
          nowPlayingMovies != null;
      if (isValid) {
        //updating the ui with fetched datas
        emit(
          HomeDataLoadedState(
            topRatedMovies: topRatedMovies,
            popularMovies: popularMovies,
            nowPlayingMovies: nowPlayingMovies,
          ),
        );
      } else {
        //changing the state becouse some of fetched movies list are null
        emit(HomeInitial());
      }
    });
  }
}
