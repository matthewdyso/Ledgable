import 'package:flutter/material.dart';
import 'package:Ledgable/book.dart';
import 'package:Ledgable/shelf.dart';

List<String> options = ['Date (Newest)', 'Date (Oldest)', 'Title A-Z', 'Title Z-A', 'Author A-Z', 'Author Z-A'];

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

    //retrieve width and height of screen in context

    // double width = 400;
    // double height = 600;

    //maximum word limit is 57 characters
    Book harryPotter = Book('Harry Potter and the Order of the Phoenix And the buss do', 'J. K. Rowling', 'He said calmly', DateTime.now());
    Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime.now());
    Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now());
    Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now());


    // Create a Shelf instance to hold books
    shelf = Shelf(width: 0, height: 0);
    shelf.addBook(harryPotter);
    shelf.addBook(got);
    shelf.addBook(idk);
    shelf.addBook(random);
  }

  void handleAddBook() {
    // This is where you define what happens when the Add Book button is pressed
    // For example, you can add a new book with default values

    setState(() {
      Book newBook = Book('New Book', 'New Author', 'New Summary', DateTime.now());
      shelf.addBook(newBook);
      print('Book added: ${newBook.title}');
    });
  }

  MenuAnchor sortButton() {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
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
              shelf = Shelf(width: shelf.width, height: shelf.height)..books = shelf.books;
            });
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
            //SortButton(shelf : shelf, onSort: () {  },),
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

void main() {
  runApp(const LedgableApp());
}
