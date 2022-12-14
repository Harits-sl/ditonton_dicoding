import 'package:core/presentation/widgets/sub_heading.dart';
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
    final title = 'Popular';

    await tester.pumpWidget(_makeTestableWidget(SubHeading(
      title: title,
      onTap: () {},
      buttonKey: 'button_key',
    )));

    expect(find.byType(Row), findsWidgets);
    expect(find.text(title), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.text('See More'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
  });
}
