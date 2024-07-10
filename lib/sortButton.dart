import 'package:flutter/material.dart';
import 'book.dart';


List<String> options = ['Date', 'Title', 'Author'];


class SortButton extends StatefulWidget {

  const SortButton({super.key});

  @override
  _SortButtonState createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  List<Book> _sort = [];
  String? selectedSortOption = "Title"; // Initialize with a default value
  String dropdownValue = options.first;

  // Implement your sorting logic here
  void sortData() {
    setState(() {
      // Sort _sort list based on selectedSortOption
      // For example, if selectedSortOption is "Title", sort by title
      // You can use List.sort() method or any other sorting algorithm
      // Update _sort list accordingly
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: options.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: options.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

/*

Test for Dropdown menu


void main() => runApp(const DropdownMenuApp());

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: const Center(
          child: SortButton(),
        ),
      ),
    );
  }
}

 */

