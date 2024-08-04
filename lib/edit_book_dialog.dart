import 'package:flutter/material.dart';
import 'package:Ledgable/book.dart';
import 'package:Ledgable/color_picker_dialog.dart';


// Dialog widget to edit book details
class EditBookDialog extends StatefulWidget {
  final Function(String, String, String, Color) onSave;
  final Book bookData;
  final Function(Book) onDelete;

  const EditBookDialog({required this.onSave, required this.bookData, required this.onDelete, super.key});

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

  void _validateTitle(){
    setState(() {
      if (_titleController.text.isEmpty) {
        _titleError = 'Title cannot be empty';
      } else if (_titleController.text.length > 60) {
        _titleError = 'Title may be shortened on display';
      } else {
        _titleError = null;
      }
    });

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
            _validateTitle();
            if (_titleError == 'Title cannot be empty') {
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