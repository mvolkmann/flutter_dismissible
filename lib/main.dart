// Dismissble is not a good option because it doesn't support
// exposing a "Delete" button and waiting for it to be tapped
// before deleting an item.
// A better option is to use the flutter_swipe_action_cell library
// in pub.dev.  That is demonstrated here.
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import './extensions/widget_extensions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe to Delete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var items = ['red', 'orange', 'yellow', 'green', 'blue', 'purple'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe to Delete'),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: items.length,
          itemBuilder: (_, index) => SwipeActionCell(
            child: ListTile(title: Text(items[index])),
            key: ObjectKey(items[index]),
            trailingActions: <SwipeAction>[
              SwipeAction(
                title: 'Delete',
                onTap: (_) {
                  setState(() => items.removeAt(index));
                },
              ),
            ],
          ),
          separatorBuilder: (_, index) => Divider(
            color: Colors.black45,
            height: 1,
          ),
        ),
      ),
    );
  }
}
