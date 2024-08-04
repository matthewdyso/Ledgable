import 'package:flutter/material.dart';
import 'package:Ledgable/book.dart';
import 'package:Ledgable/shelf.dart';
import 'package:Ledgable/edit_book_dialog.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// List of sorting options
List<String> options = ['Date (Newest)', 'Date (Oldest)', 'Title A-Z', 'Title Z-A', 'Author A-Z', 'Author Z-A'];

// Main application widget
class LedgableApp extends StatefulWidget {
  const LedgableApp({super.key});

  @override
  LedgableAppState createState() => LedgableAppState();
}

class LedgableAppState extends State<LedgableApp> {
  late Shelf shelf;

  @override
  void initState() {
    super.initState();

    // Create sample books, maximum word limit is 57 characters
    Book harryPotter = Book('Harry Potter and the Order of the Phoenix, make this really long for testing', 'J. K. Rowling', 'He said calmly', DateTime.now());
    Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime.now());
    Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now());
    Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now());

    // Initialize shelf and add sample books
    shelf = Shelf();
    shelf.addBook(harryPotter);
    shelf.addBook(got);
    shelf.addBook(idk);
    shelf.addBook(random);
  }

  // Method to handle adding a new book
  void handleAddBook() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBookDialog(
          onSave: (String title, String author, String summary, Color color) {
            Book book = Book(title, author, summary, DateTime.now(), color: color);
            setState(() {
              shelf.addBook(book);
            });
          },
          bookData: Book('', '', '', DateTime.now()), // Pass an empty book for adding a new book
          onDelete: (Book book) {}, // No action needed for delete in add mode
        );
      },
    );
  }


  // Method to create the sort button with menu options
  MenuAnchor sortButton() {
    return MenuAnchor(
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.sort),
          tooltip: 'Show menu',
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        6,
            (int index) => MenuItemButton(
          onPressed: () {
            setState(() {
              shelf.sortClicked(index);
              shelf = Shelf()..books = shelf.books;
            });
          },
          child: Text(options[index]),
        ),
      ),
    );
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
          actions: [
            sortButton(),
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



// Main function to run the app
void main() {
  runApp(const MaterialApp(
    home: LedgableApp(),
  ));
}
