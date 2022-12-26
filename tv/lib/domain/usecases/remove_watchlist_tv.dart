import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  RemoveWatchlistTv(this.repository);

  final TvRepository repository;

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
