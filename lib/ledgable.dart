import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ledgable/managers/add_book_manager.dart';
import 'package:ledgable/managers/book_manager.dart';
import 'package:ledgable/managers/edit_book_manager.dart';
import 'package:ledgable/managers/sort_book_manager.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';
import 'package:ledgable/widgets/shelf_ui.dart';
import 'package:path_provider/path_provider.dart';


// Main application widget
class LedgableApp extends StatefulWidget {
  const LedgableApp({super.key});

  @override
  LedgableAppState createState() => LedgableAppState();
}

class LedgableAppState extends State<LedgableApp> {
  late Shelf shelf;
  static const List<String> options = ['Date (Newest)', 'Date (Oldest)',
    'Title A-Z', 'Title Z-A', 'Author A-Z', 'Author Z-A'];

  final SortBookManager sortBookManager = SortBookManager();
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
      hexString = "FF$hexString"; // Add alpha if not provided
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
  }

  Future<void> _initAsync() async {
    List<String> lines = await getData();
    for (int i = 0; i < lines.length; i += 5) {
      DateTime tempDate = DateTime.parse(lines[i+3]);
      Book tempBook = Book(lines[i], lines[i+1], lines[i+2], tempDate);
      String strColor = lines[i+4];
      Color tempColor = _hexToColor(strColor);
      tempBook.setColor(tempColor);
      shelf.addBookWithoutWriting(tempBook);
    }
    setState(() {
      isLoading = false;  // Update the loading state
    });
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
      builder: (BuildContext context, MenuController controller,
          Widget? child) {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          child: ShelfUI(shelf, onEditBook: handleEditBook),
        ),
      ),
    );
  }
}

