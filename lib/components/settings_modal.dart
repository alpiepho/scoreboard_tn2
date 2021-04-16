import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:scoreboard_tn/engine.dart';

class SettingsModal extends StatelessWidget {
  SettingsModal({
    required this.context,
    required this.engine,
    this.onReset,
    this.onClear,
    this.onSwap,
    this.onDone,
    // this.colorTextLeftEdit,
    // this.colorBackgroundLeftEdit,
    // this.colorTextRightEdit,
    // this.colorBackgroundRightEdit,
  });

  final BuildContext context;
  final Engine engine;
  final Function? onReset;
  final Function? onClear;
  final Function? onSwap;
  final Function? onDone;
  // final Function? colorTextLeftEdit;
  // final Function? colorBackgroundLeftEdit;
  // final Function? colorTextRightEdit;
  // final Function? colorBackgroundRightEdit;

  void colorTextLeftEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: engine.newColorTextLeft,
              onColorChanged: (color) => engine.newColorTextLeft = color,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void colorBackgroundLeftEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: engine.newColorBackgroundLeft,
              onColorChanged: (color) => engine.newColorBackgroundLeft = color,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void colorTextRightEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: engine.newColorTextRight,
              onColorChanged: (color) => engine.newColorTextRight = color,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void colorBackgroundRightEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: engine.newColorBackgroundRight,
              onColorChanged:  (color) => engine.newColorBackgroundRight = color,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                initialValue: engine.labelLeft,
                onChanged: (text) => engine.newLabelLeft = text,
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
                initialValue: engine.valueLeft.toString(),
                onChanged: (text) => engine.newValueLeftString = text,
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
                    color: engine.colorTextLeft,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorTextLeftEdit,
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
                    color: engine.colorBackgroundLeft,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorBackgroundLeftEdit,
            ),
            Divider(),
            new ListTile(
                leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Team Name'
                ),
                autofocus: false,
                initialValue: engine.labelRight,
                onChanged: (text) => engine.newLabelRight = text,
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
                initialValue: engine.valueRight.toString(),
                onChanged: (text) => engine.newValueRightString = text,
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
                    color: engine.colorTextRight,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorTextRightEdit,
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
                    color: engine.colorBackgroundRight,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
              onTap: colorBackgroundRightEdit,
            ),
            Divider(),
            new ListTile(
              title: new Text(
                'Reset All',
                style: kSettingsTextEditStyle,
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
