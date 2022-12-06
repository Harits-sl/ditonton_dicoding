import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvs usecase;
  late MockTvRepository mocTvRepository;

  setUp(() {
    mocTvRepository = MockTvRepository();
    usecase = GetWatchlistTvs(mocTvRepository);
  });

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mocTvRepository.getWatchlistTvs())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
