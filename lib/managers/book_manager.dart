import 'package:flutter/material.dart';
import 'package:ledgable/models/book.dart';

abstract class BookManager {
  void manageBook(BuildContext context, Book book);
}
