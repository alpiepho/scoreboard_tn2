import 'package:flutter/material.dart';
import 'package:scoreboard_tn/constants.dart';

class SettingsModal extends StatelessWidget {
  SettingsModal({
    required this.labelLeft,
    required this.labelRight,
    required this.valueLeft,
    required this.valueRight,
    required this.colorTextLeft,
    required this.colorBackgroundLeft,
    required this.colorTextRight,
    required this.colorBackgroundRight,
    this.onReset,
    this.onClear,
    this.onSwap,
    this.onDone,
    this.labelLeftChanged,
    this.labelRightChanged,
    this.valueLeftChanged,
    this.valueRightChanged,
    this.colorTextLeftEdit,
    this.colorBackgroundLeftEdit,
    this.colorTextRightEdit,
    this.colorBackgroundRightEdit,
  });

  final String labelLeft;
  final String labelRight;
  final String valueLeft;
  final String valueRight;
  final Color colorTextLeft;
  final Color colorBackgroundLeft;
  final Color colorTextRight;
  final Color colorBackgroundRight;
  final Function? onReset;
  final Function? onClear;
  final Function? onSwap;
  final Function? onDone;
  final Function? labelLeftChanged;
  final Function? labelRightChanged;
  final Function? valueLeftChanged;
  final Function? valueRightChanged;
  final Function? colorTextLeftEdit;
  final Function? colorBackgroundLeftEdit;
  final Function? colorTextRightEdit;
  final Function? colorBackgroundRightEdit;

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
            child: SizedBox(),
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
        child: ListView(
          children: <Widget>[
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Team Name',
                ),
                autofocus: false,
                initialValue: labelLeft,
                onChanged: labelLeftChanged as Function(String text)?,
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Team Score'
                ),
                autofocus: false,
                keyboardType: TextInputType.number,
                initialValue: valueLeft,
                onChanged: valueLeftChanged as Function(String text)?,
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              title: new Text(
                'Text Color',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: colorTextLeft,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorTextLeftEdit as Function()?,
            ),
            new ListTile(
              title: new Text(
                'Background Color',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: colorBackgroundLeft,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorBackgroundLeftEdit as Function()?,
            ),
            Divider(),
            new ListTile(
                leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Team Name'
                ),
                autofocus: false,
                initialValue: labelRight,
                onChanged: labelRightChanged as Function(String text)?,
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Team Score'
                ),
                autofocus: false,
                keyboardType: TextInputType.number,
                initialValue: valueRight,
                onChanged: valueRightChanged as Function(String text)?,
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              title: new Text(
                'Text Color',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: colorTextRight,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorTextRightEdit as Function()?,
            ),
            new ListTile(
              title: new Text(
                'Background Color',
                style: kSettingsTextStyle,
              ),
              trailing: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: colorBackgroundRight,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorBackgroundRightEdit as Function()?,
            ),
            Divider(),
            new ListTile(
              title: new Text(
                'Reset All',
                style: kSettingsTextStyle,
              ),
              trailing: new Icon(Icons.clear_all),
              onTap: onReset as void Function()?,
            ),

          ],
        ),
      ),
    );
  }
}
