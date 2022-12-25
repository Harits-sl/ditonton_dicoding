import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBloc();
  });

  test('first state should be HomeMovies', () {
    expect(homeBloc.state, HomeMovies());
  });

  blocTest<HomeBloc, HomeState>(
    'Should emit [HomeMovies] when event OnMoviesTapped called',
    build: () {
      return homeBloc;
    },
    act: (bloc) => bloc.add(OnMoviesTapped()),
    expect: () => [HomeMovies()],
  );

  blocTest<HomeBloc, HomeState>(
    'Should emit [HomeTvs] when event OnTvsTapped called',
    build: () {
      return homeBloc;
    },
    act: (bloc) => bloc.add(OnTvsTapped()),
    expect: () => [HomeTvs()],
  );
}
