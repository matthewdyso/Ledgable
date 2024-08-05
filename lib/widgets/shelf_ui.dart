import 'package:flutter/material.dart';
import 'package:Ledgable/models/book.dart';
import 'package:Ledgable/models/shelf.dart';
import 'package:Ledgable/widgets/book_ui.dart';

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
        title: const Text('Bookshelf'),
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