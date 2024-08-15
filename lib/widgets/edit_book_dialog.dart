import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ledgable/models/book.dart';

// Dialog widget to edit book details
class EditBookDialog extends StatefulWidget {
  final Function(String, String, String, Color) onSave;
  final Book bookData;
  final Function(Book) onDelete;

  const EditBookDialog({required this.onSave,
    required this.bookData, required this.onDelete, super.key});

  @override
  EditBookDialogState createState() => EditBookDialogState();
}

class EditBookDialogState extends State<EditBookDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  Color tempColor = Colors.blueGrey;
  String? _titleError;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.bookData.title;
    _authorController.text = widget.bookData.author;
    _summaryController.text = widget.bookData.summary;
    tempColor = widget.bookData.color;
  }

  // Checks whether the title is valid or not
  // (title cannot be greater than 50 characters)
  String? _validateTitle(){
    setState(() {
      if (_titleController.text.isEmpty) {
        _titleError = 'Title cannot be empty';
      } else if (_titleController.text.length >= 50) {
        _titleError = 'Title may be shortened on display';
      } else {
        _titleError = null;
      }
    });
    return _titleError;

  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Book Information'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text field for title
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              errorText: _titleError,
            ),
            onChanged: (value) {
              setState(() {
                _validateTitle();
              });
            },
          ),
          // Text field for author
          TextFormField(
            controller: _authorController,
            decoration: const InputDecoration(
              labelText: 'Author',
            ),
          ),
          // Text field for summary
          TextFormField(
            controller: _summaryController,
            decoration: const InputDecoration(
              labelText: 'Summary',
            ),
          ),
          // Row for color picker
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
                      tempColor = pickedColor;
                    });
                  }
                },
                child: const Text('Pick Color'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onDelete(widget.bookData);
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            if (_validateTitle() == 'Title cannot be empty') {
              // Do nothing if the title error is present
              null;
            } else {
              // Save the data and navigate back
              widget.onSave(
                _titleController.text,
                _authorController.text,
                _summaryController.text,
                tempColor,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),

      ],
    );
  }
}

// Stateful widget for color picker dialog,
// Color picker is used in the edit_book_dialog to set the color of the book UI
class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const ColorPickerDialog({required this.initialColor, super.key});

  @override
  ColorPickerDialogState createState() => ColorPickerDialogState();
}

class ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color tempColor;

  @override
  void initState() {
    super.initState();
    tempColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: tempColor,
          onColorChanged: (color) {
            setState(() {
              tempColor = color;
            });
          },
          labelTypes: const [],
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