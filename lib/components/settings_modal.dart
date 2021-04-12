import 'package:flutter/material.dart';

class SettingsModal extends StatelessWidget {
  SettingsModal({this.onReset, this.onClear, this.onSwap, this.onDone});

  final Function? onReset;
  final Function? onClear;
  final Function? onSwap;
  final Function? onDone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        titleSpacing: 20,
        title: Text("Settings"),
        actions: [
          Container(
            width: 50,
            child: GestureDetector(
              onTap: onClear as void Function()?,
              child: Icon(Icons.undo),
            ),
          ),
          Container(
            width: 50,
            child: GestureDetector(
              onTap: onSwap as void Function()?,
              child: Icon(Icons.swap_horiz),
            ),
          ),
          Container(
            width: 50,
            child: GestureDetector(
              onTap: onDone as void Function()?,
              child: Icon(Icons.done),
            ),
          ),
        ],
      ),
      body: Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.music_note),
                title: new Text('Team1'),
                onTap: () => {}
            ),
            new ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Team2'),
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
