import 'package:ledgable/models/book.dart';

// Shelf class to hold and manage a collection of books of the same size
class Shelf {
  List<Book> books = [];

  // Constructor to initialize shelf dimensions
  Shelf();

  // Method to add a book to the shelf
  void addBook(Book book) {
    books.add(book);
  }

  // Method to delete a book from the shelf
  void deleteBook(Book book) {
    books.remove(book);
  }

  // Method to get the list of books on the shelf
  List<Book> getBooks() {
    return books;
  }
}
