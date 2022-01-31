import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
    var tiles = <Widget>[];
    for (var index = 0; index < items.length; index++) {
      var item = items[index];
      tiles.add(
        SwipeActionCell(
          child: ListTile(title: Text(item)),
          key: ObjectKey(item),
          trailingActions: <SwipeAction>[
            SwipeAction(
              title: 'Delete',
              onTap: (CompletionHandler handler) async {
                setState(() => items.removeAt(index));
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Demo'),
      ),
      body: Center(
        child: ListView(
          //children: ListTile.divideTiles(context: context, tiles: tiles)
          children: tiles,
        ),
      ),
    );
  }
}
