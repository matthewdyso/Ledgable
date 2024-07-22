import 'package:flutter/material.dart';


/* Book class stores the data for the book. Contains a
* title, author, and summary of the book and can be
* set with multiple functions. Strings a public.*/
class Book {
  String title;
  String author;
  String summary;

  // Constructor accepts 3 arguments
  Book(this.title, this.author, this.summary);

  // Setter methods for updating properties

  //Update title
  void setTitle(String newTitle) {
    title = newTitle;
  }

  // Update summary
  void setSummary(String newSummary) {
    summary = newSummary;
  }
  // Update author
  void setAuthor(String newAuthor) {
    author = newAuthor;
  }
}

/* Creates a stateful widget for creating the visual
* book. Accepts a book, and coordinates to place the book.
* Ongoing functionality being added is onPress so that pressing
* the book will open a book_form. Stateful widgets allow for
* updating the widget's appearance and data.*/
class BookUI extends StatefulWidget {
  final Book bookData;
  final double initialX;
  final double initialY;

  const BookUI(this.bookData, this.initialX, this.initialY);

  // Updating state changes the data of the widget
  @override
  State<BookUI> createState() => _BookUIState();
}

/* Underscore prior class means it's private. Class updates
* the state of the stateful widget and allows for updating the
* book and position.*/
class _BookUIState extends State<BookUI> {
  late Book bookData;
  late double x;
  late double y;

  //initialize with starting values
  @override
  void initState() {
    super.initState();
    bookData = widget.bookData;
    x = widget.initialX;
    y = widget.initialY;
  }

  void handleBookPress() {
    print(bookData.summary);
  }

  //changes book information shown
  void updateBookData(Book newBookData) {
    setState(() {
      bookData = newBookData;
    });
  }

  //updates position of book
  void updatePosition(double newX, double newY) {
    setState(() {
      x = newX;
      y = newY;
    });
  }

  // Builds a widget that is 150x50 (H * W)
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //sets position
        Positioned(
          top: y,
          left: x,
          child: GestureDetector(
            onTap: handleBookPress,
            //sets container to contain book text
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
              //Creates rotated text box, centered in container
              child: Center(
                child: RotatedBox(
                  quarterTurns: -3,
                  child: Text(
                    bookData.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
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