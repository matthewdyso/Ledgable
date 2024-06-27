import 'package:flutter/material.dart';
import 'package:ledgable/book_form.dart';
import 'book.dart';

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
      title: 'Ledgable App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Books Display'),
        ),
        body: Center(
          child: Stack(
            children: [
              BookUI(harryPotter, 10, 100, onPress: () => handleBookPress(harryPotter)),
              BookUI(got, 70, 100, onPress: () => handleBookPress(got)),
              BookUI(idk, 130, 100, onPress: () => handleBookPress(idk)),
              BookUI(random, 190, 100, onPress: () => handleBookPress(random)),
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
