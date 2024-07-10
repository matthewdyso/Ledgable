import 'package:flutter/material.dart';


List<String> options = ['Date', 'Title', 'Author'];
enum Options { Date, Title, Author }


class SortButton extends StatefulWidget {
  const SortButton({super.key});

  @override
  _SortButtonState createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {

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
    Options? selectedMenu;

    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.sort),
          tooltip: 'Show menu',
        );
      },
      menuChildren: List<MenuItemButton>.generate(
            3,
            (int index) =>
            MenuItemButton(
              onPressed: () =>
                  setState(() => selectedMenu = Options.values[index]),
              child: Text(options[index]),
            ),
      ),
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


