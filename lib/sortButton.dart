import 'package:flutter/material.dart';
import 'package:ledgable/shelf.dart';


List<String> options = ['Date', 'Title', 'Author'];
enum Options {date, title, author}


class SortButton extends StatefulWidget {
  late Shelf shelf;

  SortButton(this.shelf);

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
    });
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
        case Options.date:
          return 1;
        case Options.title:
          return 3;
        case Options.author:
          return 5;
        default:
          return 1;
      }
    } else {
      switch (selectedMenu) {
        case Options.date:
          return 2;
        case Options.title:
          return 4;
        case Options.author:
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
        3,
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

  @override
  Widget build(BuildContext context) {
    Shelf shelf = Shelf(0, 0);
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: Center(
          child: SortButton(shelf),
        ),
      ),
    );
  }
}




