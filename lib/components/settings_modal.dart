import 'package:flutter/material.dart';
import 'package:scoreboard_tn/components/settings_card.dart';
import 'package:scoreboard_tn/constants.dart';

class SettingsModal extends StatelessWidget {
  SettingsModal({this.onReset, this.onClear, this.onSwap, this.onDone});

  final Function? onReset;
  final Function? onClear;
  final Function? onSwap;
  final Function? onDone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSettingsModalBackgroundColor,
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
            // SettingsCard(
            //     color: Colors.lightBlue,
            //     cardChild: TextField(),
            // ),
            new ListTile(
              leading: null,
              title: new Text('Away'),
              onTap: () => {}
            ),
            new ListTile(
              leading: null,
              title: new Text('0'),
              onTap: () => {},
            ),
            new ListTile(
              title: new Text('Color'),
              trailing: new Icon(Icons.color_lens),
              onTap: () => {},
            ),
            new ListTile(
                leading: null,
                title: new Text('Home'),
                onTap: () => {}
            ),
            new ListTile(
              leading: null,
              title: new Text('0'),
              onTap: () => {},
            ),
            new ListTile(
              title: new Text('Color'),
              trailing: new Icon(Icons.color_lens),
              onTap: () => {},
            ),
            new ListTile(
              title: new Text('Reset All'),
              trailing: new Icon(Icons.clear_all),
              onTap: onReset as void Function()?,
            ),

          ],
        ),
      ),
    );
  }
}
