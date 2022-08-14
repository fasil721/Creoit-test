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
      final trendings = await TmdbServices.fetchData(MovieUrlType.trending);
      final discovers = await TmdbServices.fetchData(MovieUrlType.discover);
      final upcomings = await TmdbServices.fetchData(MovieUrlType.upcoming);
      final isValid =
          trendings != null && discovers != null && upcomings != null;
      if (isValid) {
        emit(
          HomeDataLoadedState(
            discoverMovies: discovers,
            trendingMovies: trendings,
            upcomingMovies: upcomings,
          ),
        );
      } else {
        emit(HomeInitial());
      }
    });

    // on<LoadDiscoverMoviesEvent>((event, emit) async {
    //   emit(HomeListLoadingState());
    //   final result = await TmdbServices.fetchData(event.url);
    //   if (result != null) {
    //     emit(HomeListLoadedState(result));
    //   }
    // });
  }
}
