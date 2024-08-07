import 'package:flutter/material.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/models/shelf.dart';
import 'package:ledgable/widgets/edit_book_dialog.dart';
import 'package:ledgable/managers/book_manager.dart';

class AddBookManager extends BookManager {
  final Shelf shelf;

  AddBookManager(this.shelf);

  @override
  void manageBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBookDialog(
          onSave: (String title, String author, String summary, Color color) {
            Book newBook = Book(title, author, summary, DateTime.now(), color: color);
            shelf.addBook(newBook);
          },
          bookData: book,
          onDelete: (Book book) {},
        );
      },
    );
  }
}