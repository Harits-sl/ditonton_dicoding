import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
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
    await tester
        .pumpWidget(_makeTestableWidget(MovieCard(testMovie, 'button_key')));

    expect(find.text(testMovie.title!), findsOneWidget);
    expect(find.text('- Movie -'), findsOneWidget);
    expect(find.text(testMovie.overview!), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Stack), findsWidgets);
  });
}
