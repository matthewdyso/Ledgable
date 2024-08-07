import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';
import 'package:ledgable/widgets/shelf_ui.dart';
import 'package:ledgable/managers/add_book_manager.dart';
import 'package:ledgable/managers/edit_book_manager.dart';
import 'package:ledgable/managers/book_manager.dart';
import 'package:ledgable/managers/sort_book_manager.dart';

void main() {
  runApp(const MaterialApp(
    home: ledgableApp(),
  ));
}

class ledgableApp extends StatefulWidget {
  const ledgableApp({super.key});

  @override
  ledgableAppState createState() => ledgableAppState();
}

class ledgableAppState extends State<ledgableApp> {
  late Shelf shelf;
  List<String> options = ['Date (Newest)', 'Date (Oldest)', 'Title A-Z', 'Title Z-A', 'Author A-Z', 'Author Z-A'];
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
      title: 'ledgable',
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
              image: AssetImage('assets/ledgable_icon.png'),
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


/*

import 'package:flutter/material.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';
import 'package:ledgable/widgets/edit_book_dialog.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
>>>>>>> Stashed changes

//Stateless widget does not change, basically the background of the app
class ledgableApp extends StatelessWidget {
  const ledgableApp({super.key});

  @override
  Widget build(BuildContext context) {
    Book harryPotter = Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'He said calmly');
    Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins');
    Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book');
    Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0');

    void handleBookPress(Book book){
      print(book.summary);
    }

    return MaterialApp(
      title: 'ledgable',
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
              image: AssetImage('assets/ledgable_icon.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              // x increments by values of 60
              BookUI(harryPotter, 5, 100, onPress: () => handleBookPress(harryPotter)),
              BookUI(got, 65, 100, onPress: () => handleBookPress(got)),
              BookUI(idk, 125, 100, onPress: () => handleBookPress(idk)),
              BookUI(random, 185, 100, onPress: () => handleBookPress(random)),
              BookUI(harryPotter, 245, 100, onPress: () => handleBookPress(harryPotter)),
              BookUI(harryPotter, 305, 100, onPress: () => handleBookPress(harryPotter)),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const ledgableApp());
}

 */