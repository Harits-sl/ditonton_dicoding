import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_page_test.mocks.dart';

@GenerateMocks([TvListNotifier])
void main() {
  late MockTvListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(body: body),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularState).thenReturn(RequestState.Loading);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display List when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.nowPlayingTvs).thenReturn(<Tv>[]);
    when(mockNotifier.popularState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTvs).thenReturn(<Tv>[]);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTvs).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('page should have Widget CachedNetworkImage',
      (WidgetTester tester) async {
    when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockNotifier.nowPlayingTvs).thenReturn([testTv]);
    when(mockNotifier.popularState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTvs).thenReturn([testTv]);
    when(mockNotifier.topRatedState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTvs).thenReturn([testTv]);

    final listViewFinder = find.byType(CachedNetworkImage);

    await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

    expect(listViewFinder, findsWidgets);
  });
}
