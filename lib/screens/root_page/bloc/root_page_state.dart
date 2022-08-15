part of 'root_page_bloc.dart';

abstract class RootPageState {}

class RootPageInitial extends RootPageState {
  final int currentIndex;
  final screens = [
    const HomePage(),
    const ComingSoonPage(),
    const Downloads(),
  ];

  RootPageInitial(this.currentIndex);
}
