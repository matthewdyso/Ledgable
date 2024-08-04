import 'package:flutter/material.dart';
import 'package:Ledgable/book.dart';


enum Options {dateNew, dateOld, titleAZ, titleZA, authorAZ, authorZA}

/* shelf holds books of the same size and sorts them*/
class Shelf {
  List<Book> books = [];
  double initY = 30;
  double width;
  double height;

  Options? selectedMenu;

  Shelf({this.width = 0, this.height = 0});
  //Shelf(this.width, this.height);

  void setSize(double w, double h) {
    width = w;
    height = h;
  }

  void addBook(Book book) {
    books.add(book);
  }

  void deleteBook(Book book){
    books.remove(book);
  }

  List<Book> getBooks() {
    return books;
  }


  /*
  1 = Newest to oldest
  2 = Oldest to newest
  3 = Title A-Z
  4 = Title Z-A
  5 = Author A-Z
  6 = Author Z-A
   */
  int getSelection() {
    switch (selectedMenu) {
      case Options.dateNew:
        return 1;
      case Options.titleAZ:
        return 3;
      case Options.authorAZ:
        return 5;
      case Options.dateOld:
        return 2;
      case Options.titleZA:
        return 4;
      case Options.authorZA:
        return 6;
      default:
        return 1;
    }
  }



  void sortClicked(int index){
    selectedMenu = Options.values[index];
// Call sorting logic when selection changes
    books.sort((a, b) => sortBooks(a, b, getSelection()));
    getBooks();
  }


  int sortBooks(final Book a, final Book b, int selection){
    switch (selection) {
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

  void deleteBook(Book book){
    setState(() {
      shelf.deleteBook(book);
      buildBookUI();
    });
  }

  void editBook(){
    setState(() {
    });
  }

  void sortBooks(int index) {
    setState(() {
      shelf.sortClicked(index);
    });
  }

  List<BookUI> buildBookUI(){
    List<BookUI> bookUIs = [];
    for (int i = 0; i < shelf.getBooks().length; i++) {
      bookUIs.add(BookUI(shelf.getBooks()[i], onDelete: deleteBook, key: ValueKey<DateTime>(shelf.getBooks()[i].date)));
    }
    return bookUIs;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisCount: 4,
      childAspectRatio: 0.7,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 40,
      children: [...buildBookUI()],
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

        Book harryPotter = Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'He said calmly', DateTime.now());
        Book got = Book('Game of Thrones', 'George RR Martin', 'Bilbo Baggins', DateTime.now());
        Book idk = Book('IDK anymore', 'J. K. Rowling', 'IDK man this aint a book', DateTime.now());
        Book random = Book('Random Book', 'J. K. Rowling', 'probability of me being a book = 0', DateTime.now());

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

/*
  1 = Newest to oldest
  2 = Oldest to newest
  3 = Title A-Z
  4 = Title Z-A
  5 = Author A-Z
  6 = Author Z-A
*/
// int sortBooks(final Book a, final Book b, int selection) {
//   switch (selection) {
//     case 1: // Newest to oldest
//       return b.date.compareTo(a.date); // Compare dates
//     case 2: // Oldest to newest
//       return a.date.compareTo(b.date); // Compare dates
//     case 3: // Title A-Z
//       return a.title.compareTo(b.title);
//     case 4: // Title Z-A
//       return b.title.compareTo(a.title);
//     case 5: // Author A-Z
//       return a.author.compareTo(b.author);
//     case 6: // Author Z-A
//       return b.author.compareTo(a.author);
//     default:
//       return 0;
//   }
// }