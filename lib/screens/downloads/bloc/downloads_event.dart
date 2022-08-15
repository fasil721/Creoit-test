part of 'downloads_bloc.dart';

abstract class DownloadsEvent {
  const DownloadsEvent();
}

class LoadDownloadedMoviesEvent extends DownloadsEvent {}

class SignOutEvent extends DownloadsEvent {}
