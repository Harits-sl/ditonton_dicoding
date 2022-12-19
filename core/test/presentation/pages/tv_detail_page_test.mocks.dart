// Mocks generated by Mockito 5.3.2 from annotations
// in core/test/presentation/pages/tv_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:core/domain/entities/tv.dart' as _i10;
import 'package:core/domain/entities/tv_detail.dart' as _i7;
import 'package:core/domain/usecases/get_tv_detail.dart' as _i2;
import 'package:core/domain/usecases/get_tv_recommendations.dart' as _i3;
import 'package:core/domain/usecases/get_watchlist_tv_status.dart' as _i4;
import 'package:core/domain/usecases/remove_watchlist_tv.dart' as _i6;
import 'package:core/domain/usecases/save_watchlist_tv.dart' as _i5;
import 'package:core/presentation/provider/tv_detail_notifier.dart' as _i8;
import 'package:core/utils/state_enum.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTvDetail_0 extends _i1.SmartFake implements _i2.GetTvDetail {
  _FakeGetTvDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTvRecommendations_1 extends _i1.SmartFake
    implements _i3.GetTvRecommendations {
  _FakeGetTvRecommendations_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchlistTvStatus_2 extends _i1.SmartFake
    implements _i4.GetWatchlistTvStatus {
  _FakeGetWatchlistTvStatus_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveWatchlistTv_3 extends _i1.SmartFake
    implements _i5.SaveWatchlistTv {
  _FakeSaveWatchlistTv_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveWatchlistTv_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlistTv {
  _FakeRemoveWatchlistTv_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvDetail_5 extends _i1.SmartFake implements _i7.TvDetail {
  _FakeTvDetail_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailNotifier extends _i1.Mock implements _i8.TvDetailNotifier {
  MockTvDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail => (super.noSuchMethod(
        Invocation.getter(#getTvDetail),
        returnValue: _FakeGetTvDetail_0(
          this,
          Invocation.getter(#getTvDetail),
        ),
      ) as _i2.GetTvDetail);
  @override
  _i3.GetTvRecommendations get getTvRecommendations => (super.noSuchMethod(
        Invocation.getter(#getTvRecommendations),
        returnValue: _FakeGetTvRecommendations_1(
          this,
          Invocation.getter(#getTvRecommendations),
        ),
      ) as _i3.GetTvRecommendations);
  @override
  _i4.GetWatchlistTvStatus get getWatchlistTvStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchlistTvStatus),
        returnValue: _FakeGetWatchlistTvStatus_2(
          this,
          Invocation.getter(#getWatchlistTvStatus),
        ),
      ) as _i4.GetWatchlistTvStatus);
  @override
  _i5.SaveWatchlistTv get saveWatchlistTv => (super.noSuchMethod(
        Invocation.getter(#saveWatchlistTv),
        returnValue: _FakeSaveWatchlistTv_3(
          this,
          Invocation.getter(#saveWatchlistTv),
        ),
      ) as _i5.SaveWatchlistTv);
  @override
  _i6.RemoveWatchlistTv get removeWatchlistTv => (super.noSuchMethod(
        Invocation.getter(#removeWatchlistTv),
        returnValue: _FakeRemoveWatchlistTv_4(
          this,
          Invocation.getter(#removeWatchlistTv),
        ),
      ) as _i6.RemoveWatchlistTv);
  @override
  _i7.TvDetail get tv => (super.noSuchMethod(
        Invocation.getter(#tv),
        returnValue: _FakeTvDetail_5(
          this,
          Invocation.getter(#tv),
        ),
      ) as _i7.TvDetail);
  @override
  _i9.RequestState get detailState => (super.noSuchMethod(
        Invocation.getter(#detailState),
        returnValue: _i9.RequestState.Empty,
      ) as _i9.RequestState);
  @override
  List<_i10.Tv> get tvRecommendations => (super.noSuchMethod(
        Invocation.getter(#tvRecommendations),
        returnValue: <_i10.Tv>[],
      ) as List<_i10.Tv>);
  @override
  _i9.RequestState get recommendationState => (super.noSuchMethod(
        Invocation.getter(#recommendationState),
        returnValue: _i9.RequestState.Empty,
      ) as _i9.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get isAddedToWatchlist => (super.noSuchMethod(
        Invocation.getter(#isAddedToWatchlist),
        returnValue: false,
      ) as bool);
  @override
  String get watchlistMessage => (super.noSuchMethod(
        Invocation.getter(#watchlistMessage),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i11.Future<void> fetchTvDetail(int? id) => (super.noSuchMethod(
        Invocation.method(
          #fetchTvDetail,
          [id],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchlist(_i7.TvDetail? tv) => (super.noSuchMethod(
        Invocation.method(
          #addWatchlist,
          [tv],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlist(_i7.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [tv],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
        Invocation.method(
          #loadWatchlistStatus,
          [id],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
