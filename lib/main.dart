import 'package:flutter/material.dart';
import 'book.dart';
import 'sortButton.dart';
import 'shelf.dart';

class LedgableApp extends StatefulWidget {
  const LedgableApp({super.key});

  @override
  _LedgableAppState createState() => _LedgableAppState();
}

class _LedgableAppState extends State<LedgableApp> {
  late Shelf shelf;

  @override
  void initState() {
    super.initState();

    double width = WidgetsBinding.instance.window.physicalSize.width;    // Gives the width
    double height = WidgetsBinding.instance.window.physicalSize.height;  // Gives the height

    print('width: $width, height: $height');
    Book harryPotter = Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'He said calmly');
    Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins');
    Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book');
    Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0');

    // Create a Shelf instance to hold books
    shelf = Shelf(width, height);
    shelf.addBook(harryPotter);
    shelf.addBook(got);
    shelf.addBook(idk);
    shelf.addBook(random);
  }

  void handleAddBook() {
    // This is where you define what happens when the Add Book button is pressed
    // For example, you can add a new book with default values
    setState(() {
      Book newBook = Book('New Book', 'New Author', 'New Summary');
      shelf.addBook(newBook);
      print('Book added: ${newBook.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ledgable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const SizedBox(
            width: 50, // Adjust width as needed
            height: 50, // Adjust height as needed
            child: Image(
              image: AssetImage('assets/Ledgable_icon.png'),
              fit: BoxFit.contain,
            ),
          ),
          leading: const SortButton(),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: handleAddBook,
              tooltip: 'Add Book',
            ),
          ],
        ),
        body: Center(
          child: ShelfUI(shelf),
        ),
      ),
    );
  }
}

void main() {
  runApp(const LedgableApp());
}
