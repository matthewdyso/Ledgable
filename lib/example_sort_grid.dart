import 'package:flutter/material.dart';

void main() {
  runApp(SortableGridViewApp());
}

class SortableGridViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sortable GridView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SortableGridView(),
    );
  }
}

class SortableGridView extends StatefulWidget {
  @override
  _SortableGridViewState createState() => _SortableGridViewState();
}

class _SortableGridViewState extends State<SortableGridView> {
  List<Item> items = List.generate(
    20,
        (index) => Item(name: 'Item $index', value: index),
  );

  String _currentSort = 'Name';

  void _sortItems(String sortBy) {
    setState(() {
      if (sortBy == 'Name') {
        items.sort((a, b) => a.name.compareTo(b.name));
      } else if (sortBy == 'Value') {
        items.sort((a, b) => a.value.compareTo(b.value));
      }
      _currentSort = sortBy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sortable GridView'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _sortItems,
            itemBuilder: (BuildContext context) {
              return {'Name', 'Value'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: Card(
              child: Center(
                child: Text('${items[index].name}'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Item {
  final String name;
  final int value;

  Item({required this.name, required this.value});
}
