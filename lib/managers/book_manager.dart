import 'package:flutter/material.dart';
import 'package:Ledgable/models/book.dart';

abstract class BookManager {
  void manageBook(BuildContext context, Book book);
}
