import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/widgets/edit_book_dialog.dart';
import 'package:path_provider/path_provider.dart';


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/book_data.txt');
}

Future<File> editBook(Book book) async {
  final file = await _localFile;
  List<String> lines = await file.readAsLines();

  // Find the index of the book entry
  int index = lines.indexWhere((line) => line == book.date.toString());
  if (index == -1) {
    throw Exception('Book not found');
  }
  print("INDEX OF BOOK: $index");
  // Update the book entry
  lines[index - 3] = book.title;
  lines[index - 2] = book.author;
  lines[index - 1] = book.summary;
  lines[index] = book.date.toString();
  lines[index + 1] = book.color.toHexString();

  // Rewrite the file with the remaining lines
  final newContents = lines.join('\n') + (lines.isNotEmpty ? '\n' : '');
  print(newContents);
  await file.writeAsString(newContents);

  // Write the updated lines back to the file
  return file;
}

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
              editBook(bookData);
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