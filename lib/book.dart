import 'package:flutter/material.dart';


/* Book class stores the data for the book. Contains a
* title, author, and summary of the book and can be
* set with multiple functions. Strings a public.*/
class Book {
  String title;
  String author;
  String summary;
  DateTime date;

  // Constructor accepts 3 arguments
  Book(this.title, this.author, this.summary, this.date);

  // Setter methods for updating properties

  //Update title
  void setTitle(String newTitle) {
    title = newTitle;
  }

  // Update summary
  void setSummary(String newSummary) {
    summary = newSummary;
  }
  // Update author
  void setAuthor(String newAuthor) {
    author = newAuthor;
  }

  void setDate(DateTime newDate) {
    date = newDate;
  }

}

/* Creates a stateful widget for creating the visual
* book. Accepts a book, and coordinates to place the book.
* Ongoing functionality being added is onPress so that pressing
* the book will open a book_form. Stateful widgets allow for
* updating the widget's appearance and data.*/
class BookUI extends StatefulWidget {
  final Book bookData;

  const BookUI(this.bookData, {super.key});

  //Getters to access bookdata
  String getTitle(){
    return bookData.title;
  }
  String getSummary(){
    return bookData.summary;
  }

  String getAuthor(){
    return bookData.author;
  }

  DateTime getDate(){
    return bookData.date;
  }

  // Updating state changes the data of the widget
  @override
  State<BookUI> createState() => _BookUIState();
}

/* Underscore prior class means it's private. Class updates
* the state of the stateful widget and allows for updating the
* book and position.*/
class _BookUIState extends State<BookUI> {
  late Book bookData;

  @override
  void initState() {
    super.initState();
    bookData = widget.bookData;
  }

  void handleBookPress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: bookData.title,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  onChanged: (value) {
                    setState(() {
                      bookData.setTitle(value);
                    });
                  },
                ),
                TextFormField(
                  initialValue: bookData.author,
                  decoration: const InputDecoration(
                    labelText: 'Author',
                  ),
                  onChanged: (value) {
                    setState(() {
                      bookData.setAuthor(value);
                    });
                  },
                ),
                TextFormField(
                  initialValue: bookData.summary,
                  decoration: const InputDecoration(
                    labelText: 'Summary',
                  ),
                  onChanged: (value) {
                    setState(() {
                      bookData.setSummary(value);
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: handleBookPress,
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blueGrey, //Book Cover color
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Align(
              alignment: const Alignment(0.0, -0.7),
              child: Text(
                bookData.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,  //Text Color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
