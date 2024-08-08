
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/widgets/edit_book_dialog.dart';

/* Creates a stateful widget for creating the visual
* book. Accepts a book, and coordinates to place the book.
* Ongoing functionality being added is onPress so that pressing
* the book will open a book_form. Stateful widgets allow for
* updating the widget's appearance and data.*/
class BookUI extends StatefulWidget {
  final Book bookData;
  final Function(Book) onDelete;

  const BookUI(this.bookData, {super.key, required this.onDelete});

  // Updating state changes the data of the widget
  @override
  State<BookUI> createState() => _BookUIState();
}

/* Underscore prior class means it's private. Class updates
* the state of the stateful widget and allows for updating the
* book and position.*/
class _BookUIState extends State<BookUI> {
  late Book bookData;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    bookData = widget.bookData;
    print(bookData.color.computeLuminance());
    textColor = bookData.color.computeLuminance() > 0.18 ?
    Colors.black : Colors.white;
  }

  // Function to handle book press and show dialog to edit book properties
  void handleBookPress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBookDialog(
          onSave: (String title, String author, String summary, Color color) {
            setState(() {
              bookData.title = title;
              bookData.author = author;
              bookData.summary = summary;
              bookData.color = color;
              textColor = bookData.color.computeLuminance() > 0.18 ?
                Colors.black : Colors.white;
            });
          },
          bookData: bookData,
          onDelete: (Book book) {
            setState(() {
              widget.onDelete(book);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: handleBookPress,
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              color: bookData.color,
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
            child: Align(
              alignment: const Alignment(0.0, -0.7),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: AutoSizeText(
                  wrapWords: false,
                  minFontSize: 12,
                  maxLines: 5,
                  bookData.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: textColor,
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