import 'package:flutter/material.dart';
import 'package:Ledgable/book.dart';

enum Options { dateNew, dateOld, titleAZ, titleZA, authorAZ, authorZA }

/* shelf holds books of the same size and sorts them*/
class Shelf {
  List<Book> books = [];
  double initY = 30;
  double width;
  double height;

  Options? selectedMenu;

  Shelf({this.width = 0, this.height = 0});

  void setSize(double w, double h) {
    width = w;
    height = h;
  }

  void addBook(Book book) {
    books.add(book);
  }

  void deleteBook(Book book) {
    books.remove(book);
  }

  List<Book> getBooks() {
    return books;
  }

  void sortClicked(int index) {
    books.sort((a, b) => sortBooks(a, b, Options.values[index]));
    getBooks();
  }

  int sortBooks(final Book a, final Book b, Options? selection) {
    switch (selectedMenu) {
      case Options.dateNew:
        return b.date.compareTo(a.date);
      case Options.titleAZ:
        return a.title.compareTo(b.title);
      case Options.authorAZ:
        return a.author.compareTo(b.author);
      case Options.dateOld:
        return a.date.compareTo(b.date);
      case Options.titleZA:
        return b.title.compareTo(a.title);
      case Options.authorZA:
        return b.author.compareTo(a.author);
      default:
        return 0;
    }
  }
}

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

  void editBook() {
    setState(() {});
  }

  void sortBooks(int index) {
    setState(() {
      shelf.sortClicked(index);
    });
  }
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

void main() => runApp(const ShelfApp());

class ShelfApp extends StatelessWidget {
  const ShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

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
}
