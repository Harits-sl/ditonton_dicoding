import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/home_bloc.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

// Home Bloc
class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockHomeEvent extends Fake implements HomeEvent {}

class MockHomeState extends Fake implements HomeState {}

// Movie Cubit
class MockNowPlayingMoviesCubit extends MockCubit<NowPlayingMoviesState>
    implements NowPlayingMoviesCubit {}

class MockNowPlayingMoviesState extends Fake implements NowPlayingMoviesState {}

class MockPopularMoviesCubit extends MockCubit<PopularMoviesState>
    implements PopularMoviesCubit {}

class MockPopularMoviesState extends Fake implements PopularMoviesState {}

class MockTopRatedMoviesCubit extends MockCubit<TopRatedMoviesState>
    implements TopRatedMoviesCubit {}

class MockTopRatedMoviesState extends Fake implements TopRatedMoviesState {}

// Tv Cubit
class MockNowPlayingTvsCubit extends MockCubit<NowPlayingTvsState>
    implements NowPlayingTvsCubit {}

class MockNowPlayingTvsState extends Fake implements NowPlayingTvsState {}

class MockPopularTvsCubit extends MockCubit<PopularTvsState>
    implements PopularTvsCubit {}

class MockPopularTvsState extends Fake implements PopularTvsState {}

class MockTopRatedTvsCubit extends MockCubit<TopRatedTvsState>
    implements TopRatedTvsCubit {}

class MockTopRatedTvsState extends Fake implements TopRatedTvsState {}

void main() {
  late MockHomeBloc mockHomeBloc;
  late MockNowPlayingMoviesCubit mockNowPlayingMoviesCubit;
  late MockPopularMoviesCubit mockPopularMoviesCubit;
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;
  late MockNowPlayingTvsCubit mockNowPlayingTvsCubit;
  late MockPopularTvsCubit mockPopularTvsCubit;
  late MockTopRatedTvsCubit mockTopRatedTvsCubit;

  setUpAll(() {
    registerFallbackValue(MockHomeEvent());
    registerFallbackValue(MockHomeState());
    registerFallbackValue(MockNowPlayingMoviesState());
    registerFallbackValue(MockPopularMoviesState());
    registerFallbackValue(MockTopRatedMoviesState());
    registerFallbackValue(MockNowPlayingTvsState());
    registerFallbackValue(MockPopularTvsState());
    registerFallbackValue(MockTopRatedTvsState());
  });

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    mockNowPlayingMoviesCubit = MockNowPlayingMoviesCubit();
    mockPopularMoviesCubit = MockPopularMoviesCubit();
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
    mockNowPlayingTvsCubit = MockNowPlayingTvsCubit();
    mockPopularTvsCubit = MockPopularTvsCubit();
    mockTopRatedTvsCubit = MockTopRatedTvsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => mockHomeBloc,
        ),
        BlocProvider<NowPlayingMoviesCubit>(
          create: (_) => mockNowPlayingMoviesCubit,
        ),
        BlocProvider<PopularMoviesCubit>(
          create: (_) => mockPopularMoviesCubit,
        ),
        BlocProvider<TopRatedMoviesCubit>(
          create: (_) => mockTopRatedMoviesCubit,
        ),
        BlocProvider<NowPlayingTvsCubit>(
          create: (_) => mockNowPlayingTvsCubit,
        ),
        BlocProvider<PopularTvsCubit>(
          create: (_) => mockPopularTvsCubit,
        ),
        BlocProvider<TopRatedTvsCubit>(
          create: (_) => mockTopRatedTvsCubit,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(body: body),
      ),
    );
  }

  testWidgets('All required widget should display when in home movies page',
      (WidgetTester tester) async {
    when(() => mockHomeBloc.state).thenReturn(HomeMovies());
    when(() => mockNowPlayingMoviesCubit.state)
        .thenReturn(NowPlayingMoviesLoading());
    when(() => mockPopularMoviesCubit.state).thenReturn(PopularMoviesLoading());
    when(() => mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedMoviesLoading());

    final scaffoldFinder = find.byType(Scaffold);
    final columnFinder = find.byType(Column);
    final appBarFinder = find.byType(AppBar);
    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    final ScaffoldState state = tester.firstState(scaffoldFinder);
    state.openDrawer();
    await tester.pump();

    expect(columnFinder, findsWidgets);
    expect(appBarFinder, findsOneWidget);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('All required widget should display when in home tvs page',
      (WidgetTester tester) async {
    when(() => mockHomeBloc.state).thenReturn(HomeTvs());
    when(() => mockNowPlayingTvsCubit.state).thenReturn(NowPlayingTvsLoading());
    when(() => mockPopularTvsCubit.state).thenReturn(PopularTvsLoading());
    when(() => mockTopRatedTvsCubit.state).thenReturn(TopRatedTvsLoading());

    final scaffoldFinder = find.byType(Scaffold);
    final columnFinder = find.byType(Column);
    final appBarFinder = find.byType(AppBar);
    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomePage()));

    final ScaffoldState state = tester.firstState(scaffoldFinder);
    state.openDrawer();
    await tester.pump();

    expect(columnFinder, findsWidgets);
    expect(appBarFinder, findsOneWidget);
    expect(progressBarFinder, findsWidgets);
  });
}
