import 'package:Ledgable/widgets/book_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Ledgable/models/book.dart';

void main() {

  //unit tests
  group('Book', () {
    // Test to check if book properties are set correctly
    test('Book properties should be set correctly', () {
      final book = Book('Title', 'Author', 'Summary', DateTime(2023, 1, 1), color: Colors.red);

      expect(book.title, 'Title');
      expect(book.author, 'Author');
      expect(book.summary, 'Summary');
      expect(book.date, DateTime(2023, 1, 1));
      expect(book.color, Colors.red);
    });

    // Test to check if book setters update properties correctly
    test('Book setters should update properties correctly', () {
      final book = Book('Title', 'Author', 'Summary', DateTime(2023, 1, 1));

      book.setTitle('New Title');
      book.setAuthor('New Author');
      book.setSummary('New Summary');
      book.setDate(DateTime(2024, 1, 1));
      book.setColor(Colors.blue);

      expect(book.title, 'New Title');
      expect(book.author, 'New Author');
      expect(book.summary, 'New Summary');
      expect(book.date, DateTime(2024, 1, 1));
      expect(book.color, Colors.blue);
    });
  });



  //widget tests
  group('BookUI', () {
    // Test to check if BookUI displays book title
    testWidgets('BookUI should display book title', (WidgetTester tester) async {
      final book = Book('Title', 'Author', 'Summary', DateTime(2023, 1, 1));

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BookUI(book, key:ValueKey<DateTime>(book.date), onDelete: (Book book) {}),
        ),
      ));

      expect(find.text('Title'), findsOneWidget);
    });

    // Test to check if BookUI calls onDelete when delete button is pressed
    testWidgets('BookUI should call onDelete when delete button is pressed', (WidgetTester tester) async {
      final book = Book('Title', 'Author', 'Summary', DateTime(2023, 1, 1));
      bool deleted = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BookUI(book, key:ValueKey<DateTime>(book.date), onDelete: (Book book) {
            deleted = true;
          }),
        ),
      ));

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      await tester.tap(find.text('Delete'));
      await tester.pump();

      expect(deleted, isTrue);
    });
  });
}
