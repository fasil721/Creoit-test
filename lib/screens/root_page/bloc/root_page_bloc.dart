import 'package:bloc/bloc.dart';
import 'package:netflix_clone/screens/coming_soon/coming_soon.dart';
import 'package:netflix_clone/screens/downloads/downloads.dart';
import 'package:netflix_clone/screens/home/home.dart';

part 'root_page_event.dart';
part 'root_page_state.dart';

class RootPageBloc extends Bloc<RootPageEvent, RootPageState> {
  RootPageBloc() : super(RootPageInitial(0)) {
    on<RootPageIndexChangeEvent>((event, emit) {
      //updating the screnn when the index changing
      emit(RootPageInitial(event.index));
    });
  }
}
