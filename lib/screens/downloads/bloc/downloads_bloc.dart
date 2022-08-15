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
      emit(DownloadedMoviesLoadingState());
      final result = await TmdbServices.fetchData(MovieUrlType.upcoming);
      if (result != null) {
        emit(DownloadedMoviesLoadedState(result));
      }
    });
    on<SignOutEvent>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const MobileSignUpView());
    });
  }
}
