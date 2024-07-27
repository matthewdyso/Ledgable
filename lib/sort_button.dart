import 'package:flutter/material.dart';
import 'package:Ledgable/shelf.dart';


List<String> options = ['Date (Oldest)', 'Date (Newest)', 'Title A-Z', 'Title Z-A', 'Author A-Z', 'Author Z-A'];
enum Options {dateOld, dateNew, titleAZ, titleZA, authorAZ, authorZA}


class SortButton extends StatefulWidget {
  final Shelf shelf;
  final VoidCallback onSort; // Callback function

  const SortButton({required this.shelf, required this.onSort, Key? key}) : super(key: key);

  @override
  SortButtonState createState() => SortButtonState();
}

class SortButtonState extends State<SortButton> {
  Options? selectedMenu;
  bool isToggled = false;


  // Implement your sorting logic here
  void sortData() {
    setState(() {
      // Sort _sort list based on selectedSortOption
      // For example, if selectedSortOption is "Title", sort by title
      // You can use List.sort() method or any other sorting algorithm
      // Update _sort list accordingly
      widget.shelf.books.sort( (a,b) => sortBooks(a, b, getSelection()) );
      widget.shelf.getBooks();
      widget.onSort();

    });

    void updateUI() {
      setState(() {});
    }

  }


  /*
  1 = Newest to oldest
  2 = Oldest to newest
  3 = Title A-Z
  4 = Title Z-A
  5 = Author A-Z
  6 = Author Z-A
   */
  int getSelection() {
    if(!isToggled) {
      switch (selectedMenu) {
        case Options.dateOld:
          return 1;
        case Options.titleAZ:
          return 3;
        case Options.authorAZ:
          return 5;
        default:
          return 1;
      }
    } else {
      switch (selectedMenu) {
        case Options.dateNew:
          return 2;
        case Options.titleZA:
          return 4;
        case Options.authorZA:
          return 6;
        default:
          return 1;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
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
        6,
            (int index) => MenuItemButton(
          onPressed: () {
            setState(() {
              if (selectedMenu == Options.values[index]) {
                isToggled = !isToggled;
              } else {
                selectedMenu = Options.values[index];
                sortData(); // Call sorting logic when selection changes
                isToggled = false;
              }
              //print(getSelection());
            });

            //call the function that will resort the ui

          },
          child: Text(options[index]),
        ),
      ),
    );
  }
}


void main() => runApp(const DropdownMenuApp());

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  get updateUI => null;

  @override
  Widget build(BuildContext context) {
    Shelf shelf = Shelf(width: 0, height: 0);
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: Center(
          child: SortButton(shelf: shelf, onSort: updateUI),
        ),
      ),
    );
  }
}




