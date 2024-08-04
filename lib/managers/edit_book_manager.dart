import 'package:flutter/material.dart';
import 'package:Ledgable/models/book.dart';
import 'package:Ledgable/widgets/edit_book_dialog.dart';
import 'package:Ledgable/managers/book_manager.dart';

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

