import 'package:Ledgable/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/book_data.txt');
}

Future<File> writeBook(String _title, String _author, String _summary, DateTime _date, String _picked) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('$_title\n$_author\n$_summary\n$_date\n$_picked\n', mode: FileMode.append);
}

Future<File> delBook(String name) async {
  bool flag = false;
  final file = await _localFile;
  Future<List<String>> futureLines = file.readAsLines();
  List<String> lines = await futureLines;
  // Remove the book details from the list of lines
  for (int i = 0; i < lines.length; i += 5) {
    String titleLine = lines[i];
    //print("does $name == $titleLine?\n");
    if (name == titleLine) {
      // Remove the book details (4 lines)
      lines.removeRange(i, i + 5);
      //print("Deleted $name\n");
      flag = true;
      break;
    }
  }
  if (flag) {
    // Rewrite the file with the remaining lines
    final newContents = lines.join('\n') + (lines.isNotEmpty ? '\n' : '');
    await file.writeAsString(newContents);
    //print("file will now be:\n$newContents");
  }
  //file.writeAsString("");
  //print("Done...\n");
  return file;
}

import 'package:ledgable/models/book.dart';

// Shelf class to hold and manage a collection of books of the same size
class Shelf {
  List<Book> books = [];

  // Constructor to initialize shelf dimensions
  Shelf();

  // Method to add a book to the shelf
  void addBook(Book book) {
    books.add(book);
    writeBook(book.title,book.author,book.summary,book.date, book.color.toHexString());
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
