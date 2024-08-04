import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:auto_size_text/auto_size_text.dart';


/* Book class stores the data for the book. Contains a
* title, author, and summary of the book and can be
* set with multiple functions. Strings a public.*/
class Book {
  String title;
  String author;
  String summary;
  DateTime date;
  Color color;

  // Constructor accepts 4 arguments
  Book(this.title, this.author, this.summary, this.date, {this.color = Colors.blueGrey});

  String getTitle(){
    return title;
  }

  // setters
  void setTitle(String newTitle) {
    title = newTitle;
  }
  void setSummary(String newSummary) {
    summary = newSummary;
  }
  void setAuthor(String newAuthor) {
    author = newAuthor;
  }
  void setDate(DateTime newDate) {
    date = newDate;
  }
  void setColor(Color newColor) {
    color = newColor;
  }
}

/* Creates a stateful widget for creating the visual
* book. Accepts a book, and coordinates to place the book.
* Ongoing functionality being added is onPress so that pressing
* the book will open a book_form. Stateful widgets allow for
* updating the widget's appearance and data.*/
class BookUI extends StatefulWidget {
  final Book bookData;
  final Function(Book) onDelete;

  const BookUI(this.bookData, {super.key, required this.onDelete});

  //Getters to access book data
  String getTitle() {
    return bookData.getTitle();
  }
  String getSummary() {
    return bookData.summary;
  }
  String getAuthor() {
    return bookData.author;
  }
  DateTime getDate() {
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
  String? _titleError = null;

  @override
  void initState() {
    super.initState();
    bookData = widget.bookData;
  }


  /* when Book is pressed, dialogue is displayed to change Books properties*/
  void handleBookPress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color tempColor = bookData.color;
        return Dialog(
          child: Container(
            width: 300,
            height: 320,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: bookData.title,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    errorText: _titleError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value == null || value.isEmpty) {
                        _titleError = 'Title cannot be empty';
                      } else if (value.length > 57) {
                        _titleError = 'Title is too long, will be shortened on display';
                        bookData.setTitle(value);
                      } else {
                        _titleError = null;
                        bookData.setTitle(value);
                      }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Color:'),
                    OutlinedButton(
                      onPressed: () async {
                        Color? pickedColor = await showDialog<Color>(
                          context: context,
                          builder: (context) => ColorPickerDialog(
                            initialColor: tempColor,
                          ),
                        );
                        if (pickedColor != null) {
                          setState(() {
                            bookData.setColor(pickedColor); // Update book color
                          });
                        }
                      },
                      child: const Text('Pick Color'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Delete button
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          widget.onDelete(bookData); // Use the callback
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                    // Save Button
                    OutlinedButton(
                      onPressed: _titleError == 'Title cannot be empty' ? null : () { Navigator.of(context).pop(); },
                      child: const Text('Save'),
                    ),
                  ],
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
              color: bookData.color,
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
              child: AutoSizeText(
                minFontSize: 12,
                maxLines: 5,
                bookData.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black, // Text Color
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


/* color picker is accessed via book press, sets the color of book*/
class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;

  const ColorPickerDialog({required this.initialColor, super.key});

  @override
  Widget build(BuildContext context) {
    Color tempColor = initialColor;

    return AlertDialog(
      title: const Text('Pick a color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: initialColor,
          onColorChanged: (color) {
            tempColor = color;
          },
          labelTypes: [], // Use this to disable labels instead of showLabel
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () {
            Navigator.of(context).pop(tempColor);
          },
        ),
      ],
    );
  }
}
