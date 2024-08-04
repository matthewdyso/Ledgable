import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Ledgable/main.dart';
import 'package:Ledgable/book.dart';
import 'package:Ledgable/shelf.dart';

void main() {
  testWidgets('LedgableApp should display books', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LedgableApp()));

    expect(find.text('Harry Potter and the Order of the Phoenix And the buss do'), findsOneWidget);
    expect(find.text('Game of Thrones'), findsOneWidget);
    expect(find.text('IDK anymore'), findsOneWidget);
    expect(find.text('Random Book'), findsOneWidget);
  });

  testWidgets('LedgableApp should add a book when add button is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LedgableApp()));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.enterText(find.byType(TextField).at(0), 'New Book');
    await tester.enterText(find.byType(TextField).at(1), 'New Author');
    await tester.enterText(find.byType(TextField).at(2), 'New Summary');
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('New Book'), findsOneWidget);
  });

  testWidgets('LedgableApp should sort books when sort button is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LedgableApp()));

    await tester.tap(find.byIcon(Icons.sort));
    await tester.pump();
    await tester.tap(find.text('Title A-Z'));
    await tester.pump();

    expect(find.text('Game of Thrones'), findsOneWidget);
  });
}
