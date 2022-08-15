part of 'root_page_bloc.dart';

abstract class RootPageEvent {}

class RootPageIndexChangeEvent extends RootPageEvent {
  final int index;

  RootPageIndexChangeEvent(this.index);
}
