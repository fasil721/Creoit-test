import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/datas/constants.dart';
import 'package:netflix_clone/models/movie_models.dart';
import 'package:netflix_clone/screens/mobile_signup_view/mobile_signup_view.dart';
import 'package:netflix_clone/services/tmdb_service.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';

class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  DownloadsBloc() : super(DownloadedMoviesLoadingState()) {
    on<LoadDownloadedMoviesEvent>((event, emit) async {
      // triggering loading event
      emit(DownloadedMoviesLoadingState());
      //fetching upcoming movies from the api
      final result = await TmdbServices.fetchData(MovieUrlType.upcoming);
      if (result != null) {
        //updating the ui with new data
        emit(DownloadedMoviesLoadedState(result));
      }
    });
    on<SignOutEvent>((event, emit) async {
      //signing out the user and redirecting the signing page
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const MobileSignUpView());
    });
  }
}
