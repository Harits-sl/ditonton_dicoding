import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(TvCard(testTv, 'button_key')));

    expect(find.text(testTv.name!), findsOneWidget);
    expect(find.text('- Tv Series -'), findsOneWidget);
    expect(find.text(testTv.overview!), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Stack), findsWidgets);
  });
}
