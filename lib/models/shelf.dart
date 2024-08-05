import 'package:Ledgable/models/book.dart';

// Enum to define sorting options
enum Options { dateNew, dateOld, titleAZ, titleZA, authorAZ, authorZA }

// Shelf class to hold and manage a collection of books of the same size and sorts them
class Shelf {
  List<Book> books = [];
  Options? selectedMenu;

  // Constructor to initialize shelf dimensions
  Shelf();

  void addBook(Book book) {
    books.add(book);
  }

  void deleteBook(Book book) {
    books.remove(book);
  }

  List<Book> getBooks() {
    return books;
  }

  // Method to handle sorting when a sort option is clicked
  void sortClicked(int index) {
    books.sort((a, b) => sortBooks(a, b, Options.values[index]));
  }

  // Method to sort books based on the selected option
  int sortBooks(final Book a, final Book b, Options? selection) {
    switch (selection) {
      case Options.dateNew:
        return b.date.compareTo(a.date);
      case Options.titleAZ:
        return a.title.compareTo(b.title);
      case Options.authorAZ:
        return a.author.compareTo(b.author);
      case Options.dateOld:
        return a.date.compareTo(b.date);
      case Options.titleZA:
        return b.title.compareTo(a.title);
      case Options.authorZA:
        return b.author.compareTo(a.author);
      default:
        return 0;
    }
  }
}
