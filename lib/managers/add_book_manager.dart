import 'package:flutter/material.dart';
import 'package:ledgable/managers/book_manager.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';
import 'package:ledgable/widgets/edit_book_dialog.dart';

class AddBookManager extends BookManager {
  final Shelf shelf;
  final Function() onBookAdded;

  AddBookManager(this.shelf, this.onBookAdded);

  @override
  void manageBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBookDialog(
          onSave: (String title, String author, String summary, Color color) {
            Book newBook = Book(title, author, summary, DateTime.now(),
                color: color);
            shelf.addBook(newBook);
            onBookAdded(); // Call the callback to update the UI
          },
          bookData: book,
          onDelete: (Book book) {},
        );
      },
    );
  }
}
