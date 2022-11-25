import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of tvs from repository', () async {
    // arrange
    when(mockTvRepository.getPopularTvs()).thenAnswer((_) async => Right(tTvs));
    // assert
    final result = await usecase.execute();
    // act
    expect(result, Right(tTvs));
  });
}
