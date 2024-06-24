import 'package:flutter/material.dart';

class Book{
  String title;
  String summary;
  String author;
  double y;
  double x;

  Book(this.title, this.author, this.summary, this.x, this.y);

  // Setter methods for updating properties
  void setTitle(String newTitle) {
    title = newTitle;
  }

  void setSummary(String newSummary) {
    summary = newSummary;
  }

  void setAuthor(String newAuthor) {
    author = newAuthor;
  }

  void setPosition(double newX, double newY) {
    x = newX;
    y = newY;
  }

}

class BookUI extends StatelessWidget {
  final Book bookData;

  const BookUI(this.bookData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: bookData.y,
          left: bookData.x,
          child: Container(
            width: 50,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: -3,
                child: Text(
                  bookData.title,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


void main() {

  Book harryPotter = Book('Harry Potter and the Order of the Phoenix', 'J. K. Rowling', 'massive yap', 10, 100);
  Book got = Book('Game of Thrones', 'George RR Martin', 'massive yap', 70, 100);
  Book idk = Book('IDK anymore', 'J. K. Rowling', 'massive yap', 130, 100);
  Book random = Book('Random Book', 'J. K. Rowling', 'massive yap', 190, 100);

  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Stack(
          children: [
            BookUI(harryPotter),
            BookUI(got),
            BookUI(idk),
            BookUI(random),
          ],
        ),
      ),
    ),
  ));
}
