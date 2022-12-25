import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeMovies()) {
    on<OnMoviesTapped>((event, emit) {
      emit(HomeMovies());
    });
    on<OnTvsTapped>((event, emit) {
      emit(HomeTvs());
    });
  }
}
