import 'book.dart';

class Shelf {
  //Create a list of growable list of books
  List<Book> books = [];//may want to limit # in future???

  //Constuctor
  Shelf();

  //add book to list
  void addBook(Book book) {
    books.add(book);
  }
  

}

/*
  1 = Newest to oldest
  2 = Oldest to newest
  3 = Title A-Z
  4 = Title Z-A
  5 = Author A-Z
  6 = Author Z-A
   */
int sortBooks(final Book a, final Book b, int selection){
  switch(selection) {
    case 1: // Newest to oldest
      return b.date.compareTo(a.date); // Compare dates
    case 2: // Oldest to newest
      return a.date.compareTo(b.date); // Compare dates
    case 3: // Title A-Z
      return a.title.compareTo(b.title);
    case 4: // Title Z-A
      return b.title.compareTo(a.title);
    case 5: // Author A-Z
      return a.author.compareTo(b.author);
    case 6: // Author Z-A
      return b.author.compareTo(a.author);
    default:
      return 0;
  }
}