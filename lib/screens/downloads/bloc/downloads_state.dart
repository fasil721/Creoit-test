part of 'downloads_bloc.dart';

abstract class DownloadsState {
  const DownloadsState();

}

class DownloadedMoviesLoadingState extends DownloadsState {
 
}

class DownloadedMoviesLoadedState extends DownloadsState {
  final List<Result> movies;
  const DownloadedMoviesLoadedState(this.movies);
 
}
