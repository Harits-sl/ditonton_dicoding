import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailCubit tvDetailCubit;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailCubit = TvDetailCubit(mockGetTvDetail);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvDetailCubit.state, TvDetailInitial());
  });

  blocTest<TvDetailCubit, TvDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailCubit;
    },
    act: (cubit) => cubit.fetchTvDetail(tId),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
  );

  blocTest<TvDetailCubit, TvDetailState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailCubit;
    },
    act: (cubit) => cubit.fetchTvDetail(tId),
    expect: () => [
      TvDetailLoading(),
      const TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
  );
}
