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
      //fetching upcoming movies from api
      final result = await TmdbServices.fetchData(MovieUrlType.upcoming);
      if (result != null) {
        //updating the ui with new data
        emit(UpcomingMoviesLoadedState(result));
      }
    });
    
    on<LoadGenresEvent>((event, emit) async {
      //fetching all the genres as List from api
      final result = await TmdbServices.genre();
      if (result != null) {
        //updating the ui with new data
        emit(LoadGenresState(result));
      }
    });
  }
}
