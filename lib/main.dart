// Dismissble is not a good option for
// implementing a list with "swipe to delete"
// because it doesn't support exposing a "Delete" button
// and waiting for it to be tapped before deleting an item.
// A better option is to use the flutter_swipe_action_cell library
// in pub.dev.  That is demonstrated here.

import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

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

const longSubtitle =
    'This is a very long subtitle that will need to wrap. This is common for paragraphs of text. Is there any limit to the length?';
const shortSubtitle = 'This is a short subtitle.';
const wrap = false;

class Item {
  String title;
  String subtitle;
  bool selected;

  Item({required this.title, this.subtitle = '', this.selected = false});
}

class _HomeState extends State<Home> {
  var items = [
    Item(title: 'red', subtitle: shortSubtitle),
    Item(title: 'orange', subtitle: longSubtitle),
    Item(title: 'yellow', subtitle: shortSubtitle),
    Item(title: 'green', subtitle: shortSubtitle),
    Item(title: 'blue', subtitle: shortSubtitle),
    Item(title: 'purple', subtitle: shortSubtitle),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe to Delete'),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: items.length,
          itemBuilder: _buildItem,
          separatorBuilder: (_, index) => Divider(
            color: Colors.black45,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index,
  ) {
    var key = ObjectKey(items[index]);
    var tile = _buildTile(index);
    if (!wrap) {
      return Dismissible(
        child: tile,
        key: key,
        onDismissed: (direction) {
          setState(() {
            items.removeAt(index);
          });
        },
      );
    }

    return SwipeActionCell(
      child: tile,
      key: key,
      trailingActions: <SwipeAction>[
        SwipeAction(
          title: 'Delete',
          onTap: (_) {
            setState(() => items.removeAt(index));
          },
        ),
      ],
    );
  }

  Widget _buildTile(int index) {
    var item = items[index];
    var selected = item.selected;
    var title = item.title;

    return ListTile(
      enabled: title != 'green',
      iconColor: Colors.blue, // icon color
      //isThreeLine: true,
      key: ObjectKey(item),
      leading: Icon(Icons.ac_unit),
      onTap: () {
        print('got tap on $title');
        setState(() {
          item.selected = !item.selected;
        });
      },
      selected: selected,
      selectedColor: Colors.green, // text and icon color
      //selectedIconColor: Colors.green, // not supported
      selectedTileColor: Colors.green[100],
      subtitle: Text(item.subtitle),
      textColor: Colors.black, // text color
      tileColor: Colors.yellow[100],
      title: Text(title),
      trailing: Icon(Icons.access_alarms),
    );
  }
}
