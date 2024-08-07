import 'package:flutter/material.dart';

/* Book class stores the data for the book. Contains a
* title, author, and summary of the book and can be
* set with multiple functions. Strings a public.*/
class Book {
  String title;
  String author;
  String summary;
  DateTime date;
  Color color;

  // Constructor to initialize book properties, accepts 4 arguments
  Book(this.title, this.author,
      this.summary, this.date, {this.color = Colors.blueGrey});

  // Setter for title
  void setTitle(String newTitle) {
    title = newTitle;
  }

  // Setter for summary
  void setSummary(String newSummary) {
    summary = newSummary;
  }

  // Setter for author
  void setAuthor(String newAuthor) {
    author = newAuthor;
  }

  // Setter for date
  void setDate(DateTime newDate) {
    date = newDate;
  }

  // Setter for color
  void setColor(Color newColor) {
    color = newColor;
  }
}

