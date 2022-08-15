import 'package:bloc/bloc.dart';
import 'package:netflix_clone/datas/constants.dart';
import 'package:netflix_clone/models/genres_model.dart';
import 'package:netflix_clone/models/movie_models.dart';
import 'package:netflix_clone/services/tmdb_service.dart';

part 'comingsoon_event.dart';
part 'comingsoon_state.dart';

class ComingsoonBloc extends Bloc<ComingsoonEvent, ComingsoonState> {
  ComingsoonBloc() : super(UpcomingMoviesLoadingState()) {
    on<LoadUpcomingMoviesEvent>((event, emit) async {
      emit(UpcomingMoviesLoadingState());
      final result = await TmdbServices.fetchData(MovieUrlType.upcoming);
      if (result != null) {
        emit(UpcomingMoviesLoadedState(result));
      }
    });

    on<LoadGenresEvent>((event, emit) async {
      final result = await TmdbServices.genre();
      if (result != null) {
        emit(LoadGenresState(result));
      }
    });
  }
}
