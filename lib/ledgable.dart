import 'package:flutter/material.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';
import 'package:ledgable/widgets/shelf_ui.dart';
import 'package:ledgable/managers/add_book_manager.dart';
import 'package:ledgable/managers/book_manager.dart';
import 'package:ledgable/managers/edit_book_manager.dart';
import 'package:ledgable/managers/sort_book_manager.dart';


// Main application widget
class LedgableApp extends StatefulWidget {
  const LedgableApp({super.key});

  @override
  LedgableAppState createState() => LedgableAppState();
}

class LedgableAppState extends State<LedgableApp> {
  late Shelf shelf;
  static const List<String> options = ['Date (Newest)', 'Date (Oldest)', 'Title A-Z', 'Title Z-A', 'Author A-Z', 'Author Z-A'];
  final SortBookManager sortBookManager = SortBookManager();

  @override
  void initState() {
    super.initState();

    Book harryPotter = Book('Harry Potter and the Order of the Phoenix And the buss do', 'J. K. Rowling', 'He said calmly', DateTime.now());
    Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime.now());
    Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now());
    Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now());

    shelf = Shelf(width: 0, height: 0);
    shelf.addBook(harryPotter);
    shelf.addBook(got);
    shelf.addBook(idk);
    shelf.addBook(random);
  }

  void handleAddBook() {
    BookManager bookManager = AddBookManager(shelf);
    bookManager.manageBook(context, Book('', '', '', DateTime.now()));
  }

  void handleEditBook(Book book) {
    BookManager bookManager = EditBookManager((Book book) {
      setState(() {
        shelf.deleteBook(book);
      });
    });
    bookManager.manageBook(context, book);
  }

  void handleSortBooks(int index) {
    setState(() {
      sortBookManager.sortBooks(shelf.getBooks(), index);
    });
  }

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
            handleSortBooks(index);
          },
          child: Text(options[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;    // Gives the width
    double height = MediaQuery.of(context).size.height;  // Gives the height

    shelf.setSize(width, height);

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