import 'package:flutter_test/flutter_test.dart';
import 'package:ledgable/shelf.dart';
import 'package:ledgable/book.dart';

void main() {
  group('Shelf', () {
    test('sorts books by title', () {
      Shelf shelf = Shelf(0, 0);
      shelf.addBook(Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'He said calmly', DateTime(2003, 6, 21)));
      shelf.addBook(Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime(1996, 8, 1)));
      shelf.addBook(Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now()));
      shelf.addBook(Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now()));

      // Sort by title
      shelf.books.sort((a, b) => sortBooks(a, b, 3));

      // Check if the books are sorted correctly
      expect(shelf.books[0].title, equals('Game of Thrones'));
      expect(shelf.books[1].title, equals('Harry Potter and the Order of the Phoenix'));
      expect(shelf.books[2].title, equals('IDK anymore'));
      expect(shelf.books[3].title, equals('Random Book'));

    });


    test('sorts books by author', () {
      Shelf shelf = Shelf(0, 0);
      shelf.addBook(Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'He said calmly', DateTime(2003, 6, 21)));
      shelf.addBook(Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime(1996, 8, 1)));
      shelf.addBook(Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now()));
      shelf.addBook(Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now()));

      // Sort by author
      shelf.books.sort((a, b) => sortBooks(a, b, 5));

      // Check if the books are sorted correctly
      expect(shelf.books[0].author, equals('George RR Martin'));
      expect(shelf.books[1].author, equals('J. K. Rowling'));
      expect(shelf.books[2].author, equals('J. K. Rowling'));
      expect(shelf.books[3].author, equals('J. K. Rowling'));
    });


    test('sorts books by date', () {
      Shelf shelf = Shelf(0, 0);
      shelf.addBook(Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'He said calmly', DateTime(2003, 6, 21)));
      shelf.addBook(Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime(1996, 8, 1)));
      shelf.addBook(Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now()));
      shelf.addBook(Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now()));

      // Sort by date
      shelf.books.sort((a, b) => sortBooks(a, b, 1));

      // Check if the books are sorted correctly
      expect(shelf.books[0].title, equals('Game of Thrones'));
      expect(shelf.books[1].title, equals('Harry Potter and the Order of the Phoenix'));
      expect(shelf.books[2].title, equals('IDK anymore'));
      expect(shelf.books[3].title, equals('Random Book'));
    });
  });
}