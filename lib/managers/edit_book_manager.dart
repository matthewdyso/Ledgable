import 'package:flutter/material.dart';
import 'package:ledgable/managers/book_manager.dart';
import 'package:ledgable/models/book.dart';
import 'package:ledgable/widgets/edit_book_dialog.dart';

class EditBookManager extends BookManager {
  final Function(Book) onDelete;

  EditBookManager(this.onDelete);

  @override
  void manageBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBookDialog(
          onSave: (String title, String author, String summary, Color color) {
            book.setTitle(title);
            book.setAuthor(author);
            book.setSummary(summary);
            book.setColor(color);
          },
          bookData: book,
          onDelete: onDelete,
        );
      },
    );
  }
}

