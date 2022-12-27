library core;

export 'styles/colors.dart';
export 'styles/text_styles.dart';

export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/route_observer.dart';
export 'utils/formatted_utils.dart';
export 'utils/http_ssl_pinning.dart';

export 'presentation/pages/home_page.dart';
export 'presentation/pages/watchlist_page.dart';

export 'presentation/widgets/movie_card_list.dart';
export 'presentation/widgets/sub_heading.dart';
export 'presentation/widgets/tv_card_list.dart';

export 'presentation/bloc/home_bloc.dart';
export 'presentation/bloc/watchlist_movie_cubit.dart';
export 'presentation/bloc/watchlist_tv_cubit.dart';

export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';
export 'data/datasources/tv_local_data_source.dart';
export 'data/datasources/tv_remote_data_source.dart';
export 'data/datasources/db/database_helper.dart';

export 'data/repositories/movie_repository_impl.dart';
export 'data/repositories/tv_repository_impl.dart';

export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_tvs.dart';

export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tv_repository.dart';

export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';
export 'domain/entities/tv.dart';
export 'domain/entities/tv_detail.dart';
export 'domain/entities/season.dart';
export 'domain/entities/genre.dart';
