import 'package:flutter/material.dart';
//hi
//helloo
class Book {
  String title;
  String summary;
  String author;

  Book(this.title, this.author, this.summary);

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
}

class BookUI extends StatefulWidget {
  final Book bookData;
  final double initialX;
  final double initialY;
  final VoidCallback onPress;

  const BookUI(this.bookData, this.initialX, this.initialY, {required this.onPress, super.key});

  @override
  State<BookUI> createState() => _BookUIState();
}

class _BookUIState extends State<BookUI> {
  late Book bookData;
  late double x;
  late double y;

  @override
  void initState() {
    super.initState();
    bookData = widget.bookData;
    x = widget.initialX;
    y = widget.initialY;
  }

  void updateBookData(Book newBookData) {
    setState(() {
      bookData = newBookData;
    });
  }

  void updatePosition(double newX, double newY) {
    setState(() {
      x = newX;
      y = newY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: y,
          left: x,
          child: GestureDetector(
            onTap: widget.onPress,
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