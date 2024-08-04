import 'package:flutter/material.dart';
import 'package:Ledgable/book.dart';

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
    getBooks();
  }

  // Method to sort books based on the selected option
  int sortBooks(final Book a, final Book b, Options? selection) {
    switch (selectedMenu) {
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

// Stateful widget to create the visual representation of a shelf
class ShelfUI extends StatefulWidget {
  final Shelf shelf;

  const ShelfUI(this.shelf, {super.key});

  @override
  ShelfUIState createState() => ShelfUIState();
}

class ShelfUIState extends State<ShelfUI> {
  late Shelf shelf;

  @override
  void initState() {
    super.initState();
    shelf = widget.shelf;
  }

  void addBook() {
    setState(() {
      Book newBook = Book('New Book', 'New Author', 'New Summary', DateTime.now());
      shelf.addBook(newBook);
      buildBookUI();
    });
  }

  void deleteBook(Book book) {
    setState(() {
      shelf.deleteBook(book);
      buildBookUI();
    });
  }


  void sortBooks(int index) {
    setState(() {
      shelf.sortClicked(index);
    });
  }

  // Method to build the UIs for the books on the shelf
  List<BookUI> buildBookUI() {
    List<BookUI> bookUIs = [];
    for (int i = 0; i < shelf.getBooks().length; i++) {
      bookUIs.add(BookUI(
        shelf.getBooks()[i],
        onDelete: deleteBook,
        key: ValueKey<DateTime>(shelf.getBooks()[i].date),
      ));
    }
    return bookUIs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shelf Sample'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 40,
        children: buildBookUI(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addBook,
        child: const Icon(Icons.add),
      ),
    );
  }
}


