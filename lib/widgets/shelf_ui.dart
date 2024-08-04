<<<<<<< Updated upstream:lib/shelf.dart
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
=======
import 'package:flutter/material.dart';
import 'package:Ledgable/models/shelf.dart';
import 'package:Ledgable/widgets/book_ui.dart';
import 'package:Ledgable/models/book.dart';
>>>>>>> Stashed changes:lib/widgets/shelf_ui.dart

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
<<<<<<< Updated upstream:lib/shelf.dart
=======

  // Method to add a new book to the shelf
  void addBook() {
    setState(() {
      Book newBook = Book('New Book', 'New Author', 'New Summary', DateTime.now());
      shelf.addBook(newBook);
      buildBookUI();
    });
  }

  // Method to delete a book from the shelf
  void deleteBook(Book book) {
    setState(() {
      shelf.deleteBook(book);
      buildBookUI();
    });
  }

  // Method to edit a book on the shelf
  void editBook() {
    setState(() {});
  }

  // Method to build the UI for the books on the shelf
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

// Main function to run the app
void main() => runApp(const ShelfApp());

// Stateless widget to create the main app
class ShelfApp extends StatelessWidget {
  const ShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        // Create sample books
        Book harryPotter = Book(
          'Harry Potter and the Order of the Phoenix',
          'J. K. Rowling',
          'He said calmly',
          DateTime.now(),
        );
        Book got = Book(
          'Game of Thrones',
          'George RR Martin',
          'Bilbo Baggins',
          DateTime.now(),
        );
        Book idk = Book(
          'IDK anymore',
          'J. K. Rowling',
          'IDK man this aint a book',
          DateTime.now(),
        );
        Book random = Book(
          'Random Book',
          'J. K. Rowling',
          'probability of me being a book = 0',
          DateTime.now(),
        );

        // Create a shelf and add sample books to it
        Shelf shelf = Shelf(width: width, height: height);
        shelf.addBook(harryPotter);
        shelf.addBook(got);
        shelf.addBook(idk);
        shelf.addBook(random);

        return MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: Scaffold(
            appBar: AppBar(title: const Text('Shelf Sample')),
            body: Center(
              child: ShelfUI(shelf),
            ),
          ),
        );
      },
    );
  }
>>>>>>> Stashed changes:lib/widgets/shelf_ui.dart
}