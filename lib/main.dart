import 'package:flutter/material.dart';
import 'book.dart';

class LedgableApp extends StatelessWidget {
  const LedgableApp({super.key});

  @override
  Widget build(BuildContext context) {
    Book harryPotter = Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'massive yap');
    Book got = Book('Game of Thrones', 'George RR Martin', 'massive yap');
    Book idk = Book('IDK anymore', 'J. K. Rowling', 'massive yap');
    Book random = Book('Random Book', 'J. K. Rowling', 'massive yap');

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
              BookUI(harryPotter, 10, 100),
              BookUI(got, 70, 100),
              BookUI(idk, 130, 100),
              BookUI(random, 190, 100),
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
