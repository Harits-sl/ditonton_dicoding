import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tvs.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetNowPlayingTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];
  test('should get list tvs from repository', () async {
    // arrange
    when(mockTvRepository.getNowPlayingTvs())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
