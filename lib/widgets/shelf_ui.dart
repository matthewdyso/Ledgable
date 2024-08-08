import 'package:flutter/material.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';
import 'package:ledgable/widgets/book_ui.dart';

// Stateful widget to create the visual representation of a shelf
class ShelfUI extends StatefulWidget {
  final Shelf shelf;
  final Function(Book) onEditBook;

  const ShelfUI(this.shelf, {required this.onEditBook, super.key});

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
      Book newBook = Book('New Book',
          'New Author', 'New Summary', DateTime.now());
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
        title: const Text('Bookshelf'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 20,
        children: buildBookUI(),
      ),
    );
  }
}