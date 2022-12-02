import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetWatchlistTvStatus {
  GetWatchlistTvStatus(this.repository);

  final TvRepository repository;

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
