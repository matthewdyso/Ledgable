import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
          labelTypes: [],
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
