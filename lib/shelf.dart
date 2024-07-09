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