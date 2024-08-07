import 'package:flutter/material.dart';
import 'package:Ledgable/models/book.dart';
import 'package:Ledgable/models/shelf.dart';
import 'package:Ledgable/widgets/shelf_ui.dart';
import 'package:Ledgable/widgets/edit_book_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
  bool isLoading = true;  // To handle loading state

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/book_data.txt');
  }

  // Function to convert hex string to Color
  Color _hexToColor(String hexString) {
    hexString = hexString.toUpperCase().replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF" + hexString; // Add alpha if not provided
    }
    return Color(int.parse(hexString, radix: 16));
  }
  Future<List<String>> getData() async {
    print("### retreiving data... ###");
    final file = await _localFile;

    // Write the file
    //String date = "2024-08-07 02:11:50.609903";
    //String color = Color.fromRGBO(100, 100, 100, 2) as String;
    //file.writeAsString('TheMeow\nkitty\nbest book ever\ndate\ncolor\n', mode: FileMode.append);
    Future<List<String>> futureLines = file.readAsLines();
    List<String> lines = await futureLines;
    return lines;
  }

  @override
  void initState() {
    super.initState();
    shelf = Shelf();
    _initAsync();
    // Create sample books, maximum word limit is 57 characters
    //Book harryPotter = Book('Harry Potter and the Order of the Phoenix, make this really long for testing', 'J. K. Rowling', 'He said calmly', DateTime.now());
    //Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime.now());
    //Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now());
    //Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now());

    // Initialize shelf and add sample books
    //shelf.addBook(harryPotter);
    //shelf.addBook(got);
    //shelf.addBook(idk);
    //shelf.addBook(random);
  }

  Future<void> _initAsync() async {
    List<String> lines = await getData();
    for (int i = 0; i < lines.length; i += 5) {
      DateTime tempDate = DateTime.parse(lines[i+3]);
      Book tempBook = Book(lines[i], lines[i+1], lines[i+2], DateTime.now());
      String strColor = lines[i+4];
      Color tempColor = _hexToColor(strColor);
      tempBook.setColor(tempColor);
      shelf.addBookWithoutWriting(tempBook);
    }
    setState(() {
      isLoading = false;  // Update the loading state
    });
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

