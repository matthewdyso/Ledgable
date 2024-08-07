import 'package:Ledgable/models/book.dart';
import 'package:flutter/material.dart';
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

Future<File> writeBook(String _title, String _author, String _summary, DateTime _date, Color _picked) async {
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


// Enum to define sorting options
enum Options { dateNew, dateOld, titleAZ, titleZA, authorAZ, authorZA }

// Shelf class to hold and manage a collection of books of the same size and sorts them
class Shelf {
  List<Book> books = [];
  Options? selectedMenu;

  // Constructor to initialize shelf dimensions
  Shelf();


  void addBook(Book book) {
    books.add(book);
    writeBook(book.title,book.author,book.summary,book.date,book.color);
  }

  void addBookWithoutWriting(Book book) {
    books.add(book);
  }

  void deleteBook(Book book) {
    books.remove(book);
    delBook(book.title);
  }

  List<Book> getBooks() {
    return books;
  }

  // Method to handle sorting when a sort option is clicked
  void sortClicked(int index) {
    books.sort((a, b) => sortBooks(a, b, Options.values[index]));
  }

  // Method to sort books based on the selected option
  int sortBooks(final Book a, final Book b, Options? selection) {
    switch (selection) {
      case Options.dateNew:
        return b.date.compareTo(a.date);
      case Options.titleAZ:
        return a.title.compareTo(b.title);
      case Options.authorAZ:
        return a.author.compareTo(b.author);
      case Options.dateOld:
        return a.date.compareTo(b.date);
      case Options.titleZA:
        return b.title.compareTo(a.title);
      case Options.authorZA:
        return b.author.compareTo(a.author);
      default:
        return 0;
    }
  }
}
