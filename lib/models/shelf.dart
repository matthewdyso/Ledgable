import 'dart:io';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ledgable/models/book.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/book_data.txt');
}

// Writes book to book_data.txt
Future<File> writeBook(String title, String author,
    String summary, DateTime date, String picked) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(
      '$title\n$author\n$summary\n$date\n$picked\n', mode: FileMode.append);
}

// Deletes book from book_data.txt
Future<File> delBook(String name) async {
  bool flag = false;
  final file = await _localFile;
  Future<List<String>> futureLines = file.readAsLines();
  List<String> lines = await futureLines;
  // Remove the book details from the list of lines
  for (int i = 0; i < lines.length; i += 5) {
    String titleLine = lines[i];
    if (name == titleLine) {
      // Remove the book details (4 lines)
      lines.removeRange(i, i + 5);
      flag = true;
      break;
    }
  }
  if (flag) {
    // Rewrite the file with the remaining lines
    final newContents = lines.join('\n') + (lines.isNotEmpty ? '\n' : '');
    await file.writeAsString(newContents);
  }
  return file;
}


// Shelf class to hold and manage a collection of books of the same size
class Shelf {
  List<Book> books = [];

  // Constructor to initialize shelf dimensions
  Shelf();

  // Method to add a book to the shelf
  void addBook(Book book) {
    books.add(book);
    writeBook(book.title,book.author,book.summary,
        book.date, book.color.toHexString());
  }

  void addBookWithoutWriting(Book book) {
    books.add(book);
  }

  // Method to delete a book from the shelf
  void deleteBook(Book book) {
    books.remove(book);
    delBook(book.title);
  }

  // Method to get the list of books on the shelf
  List<Book> getBooks() {
    return books;
  }
}
