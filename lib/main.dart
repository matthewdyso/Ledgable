import 'package:flutter/material.dart';
import 'book.dart';
import 'sortButton.dart';

//Stateless widget does not change, basically the background of the app
class LedgableApp extends StatelessWidget {
  const LedgableApp({super.key});

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
      title: 'Ledgable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Books Display'),
          centerTitle: true,
          actions: <Widget>[SortButton()],
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
  runApp(const LedgableApp());
}
