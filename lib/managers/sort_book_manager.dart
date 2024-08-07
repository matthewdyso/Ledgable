import 'package:ledgable/models/book.dart';

enum Options { dateNew, dateOld, titleAZ, titleZA, authorAZ, authorZA }

class SortBookManager {
  Options? selectedMenu;

  // Method to sort books based on the selected option
  void sortBooks(List<Book> books, int index) {
    books.sort((a, b) => _sortBooks(a, b, Options.values[index]));
  }

  int _sortBooks(final Book a, final Book b, Options selection) {
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
