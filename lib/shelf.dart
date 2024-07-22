import 'package:flutter/material.dart';
import 'package:ledgable/book.dart';

class Shelf {
  List<Book> books = [];
  List<BookUI> bookUIs = [];
  double initY = 30;
  double width;
  double height;
  double xIncr = 60;
  double yIncr = 160;

  Shelf(this.width, this.height);

  void setSize(double w, double h) {
    width = w;
    height = h;
  }

  void addBook(Book book) {
    books.add(book);
  }

  List<Widget> getBooks() {
    bookUIs.clear(); // Clear existing bookUIs before rebuilding
    double y = initY;
    int numBooksPerRow = (width ~/ xIncr);
    int padding = (width - (numBooksPerRow * xIncr)) ~/ 2;
    double x = padding.toDouble();

    int booksPerRow = 0;
    for (int i = 0; i < books.length; i++) {
      BookUI temp = BookUI(books[i], x, y);
      bookUIs.add(temp);

      x += xIncr;
      booksPerRow++;
      if (booksPerRow == numBooksPerRow) {
        y += yIncr;
        x = padding.toDouble();
        booksPerRow = 0;
      }

    }
    return bookUIs;
  }
}

class ShelfUI extends StatefulWidget {
  final Shelf shelf;

  const ShelfUI(this.shelf);

  @override
  _ShelfUIState createState() => _ShelfUIState();
}

class _ShelfUIState extends State<ShelfUI> {
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
    });
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ...shelf.getBooks(),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       ElevatedButton(
  //         onPressed: addBook,
  //         child: const Text('Add Book'),
  //       ),
  //       Expanded(
  //         child: Stack(
  //           children: [
  //             ...shelf.getBooks(),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
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

        // //
        // print(width);
        // print(height);

        Book harryPotter = Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'He said calmly', DateTime.now());
        Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime.now());
        Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now());
        Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now());

        Shelf shelf = Shelf(width, height);
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

/*
  1 = Newest to oldest
  2 = Oldest to newest
  3 = Title A-Z
  4 = Title Z-A
  5 = Author A-Z
  6 = Author Z-A
   */
int sortBooks(final Book a, final Book b, int selection){
  switch(selection) {
    case 1: // Newest to oldest
      return b.date.compareTo(a.date); // Compare dates
    case 2: // Oldest to newest
      return a.date.compareTo(b.date); // Compare dates
    case 3: // Title A-Z
      return a.title.compareTo(b.title);
    case 4: // Title Z-A
      return b.title.compareTo(a.title);
    case 5: // Author A-Z
      return a.author.compareTo(b.author);
    case 6: // Author Z-A
      return b.author.compareTo(a.author);
    default:
      return 0;
  }
}
