// Dismissble is not a good option for
// implementing a list with "swipe to delete".
// While a background containing a "Delete" button
// can be exposed when the user drags a tile to the left,
// it is hidden when they release the tile
// which gives them no opportunity to tap the button.
// A better option is to use the flutter_swipe_action_cell library
// in pub.dev.
//
// To run this app using only Dismissibles, set the wrap variable to false.
// To run this app wrapping each Dismissible in SwipeActionCell,
// set the wrap variable to true.

import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

const longSubtitle =
    'This is a very long subtitle that will need to wrap. This is common for paragraphs of text. There seems to be no limit to the length.';
const shortSubtitle = 'This is a short subtitle.';
const wrap = false;

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
  var selectedTileColor = Colors.green[100];
  var tileColor = Colors.yellow[100];

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
    var item = items[index];
    var key = ObjectKey(item);
    var tile = _buildTile(index);

    deleteFn() {
      setState(() => items.removeAt(index));
    }

    if (!wrap) {
      // Users will never get a chance to tap the Delete button
      // because it disappears as soon as they stop dragging the tile.
      var background = Row(
        children: [
          ElevatedButton(
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: deleteFn,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );

      return Dismissible(
        background: background,
        child: tile, // required
        key: key, // required
        onDismissed: (direction) => deleteFn(),
      );
    }

    return SwipeActionCell(
      // When ListTile widgets are wrapped in a SwipeActionCell,
      // their background color must be specified here.
      backgroundColor: item.selected ? selectedTileColor : tileColor,
      child: tile,
      key: key,
      trailingActions: <SwipeAction>[
        SwipeAction(
          title: 'Delete',
          onTap: (direction) => deleteFn(),
        ),
      ],
    );
  }

  Widget _buildTile(int index) {
    var item = items[index];
    var selected = item.selected;
    var title = item.title;

    // There is no selectedIconColor argument.
    return ListTile(
      enabled: title != 'green',
      iconColor: Colors.blue, // icon color
      //isThreeLine: true,
      key: ObjectKey(item),
      leading: Icon(Icons.edit),
      onTap: () {
        print('got tap on $title');
        setState(() {
          item.selected = !item.selected;
        });
      },
      selected: selected,
      subtitle: Text(item.subtitle),
      textColor: Colors.black, // text color
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(Icons.access_alarms),

      // The following arguments are ignored when
      // the ListTile is wrapped in a SwipeActionCell.
      selectedColor: Colors.green, // text and icon color
      selectedTileColor: selectedTileColor,
      tileColor: tileColor,
    );
  }
}
