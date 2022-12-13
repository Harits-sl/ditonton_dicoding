import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(find.byType(Stack), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text(AboutPage.aboutText), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
