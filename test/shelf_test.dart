import 'package:ledgable/widgets/shelf_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';

void main() {

  //unit tests
  group('Shelf', () {
    // Test to check if Shelf adds and deletes books correctly
    test('Shelf should add and delete books correctly', () {
      final shelf = Shelf();
      final book1 = Book('Title1', 'Author1', 'Summary1', DateTime(2023, 1, 1));
      final book2 = Book('Title2', 'Author2', 'Summary2', DateTime(2023, 1, 2));

      shelf.addBook(book1);
      shelf.addBook(book2);

      expect(shelf.getBooks().length, 2);

      shelf.deleteBook(book1);

      expect(shelf.getBooks().length, 1);
      expect(shelf.getBooks().first, book2);
    });

    // Test to check if Shelf sorts books correctly
    test('Shelf should sort books correctly', () {
      final shelf = Shelf();
      final book1 = Book('TitleA', 'AuthorA', 'SummaryA', DateTime(2023, 1, 1));
      final book2 = Book('TitleB', 'AuthorB', 'SummaryB', DateTime(2023, 1, 2));

      shelf.addBook(book1);
      shelf.addBook(book2);

    });
  });

  //widget tests
  group('ShelfUI', () {
    // Test to check if ShelfUI displays books
    testWidgets('ShelfUI should display books', (WidgetTester tester) async {
      final shelf = Shelf();
      final book1 = Book('Title1', 'Author1', 'Summary1', DateTime(2023, 1, 1));
      final book2 = Book('Title2', 'Author2', 'Summary2', DateTime(2023, 1, 2));

      shelf.addBook(book1);
      shelf.addBook(book2);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ShelfUI(shelf),
        ),
      ));

      expect(find.text('Title1'), findsOneWidget);
      expect(find.text('Title2'), findsOneWidget);
    });

    // Test to check if ShelfUI adds a book when add button is pressed
    testWidgets('ShelfUI should add a book when add button is pressed', (WidgetTester tester) async {
      final shelf = Shelf();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ShelfUI(shelf),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              shelf.addBook(Book('New Book', 'New Author', 'New Summary', DateTime.now()));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ));

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('New Book'), findsOneWidget);
    });
  });
}
