import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:scoreboard_tn/engine.dart';

class SettingsModal extends StatefulWidget {
  late BuildContext context;
  late Engine engine;
  late Function onReset;
  late Function onClear;
  late Function onSwap;
  late Function onDone;

  SettingsModal(
      BuildContext context,
      Engine engine,
      Function onReset,
      Function onClear,
      Function onSwap,
      Function onDone
      ) {
    this.context = context;
    this.engine = engine;
    this.onReset = onReset;
    this.onClear = onClear;
    this.onSwap = onSwap;
    this.onDone = onDone;
  }

  @override
  _SettingsModal createState() => _SettingsModal(context, engine, onReset, onClear, onSwap, onDone);
}

class _SettingsModal extends State<SettingsModal> {

  _SettingsModal(
      BuildContext context,
      Engine engine,
      Function onReset,
      Function onClear,
      Function onSwap,
      Function onDone
      ) {
    this.context = context;
    this.engine = engine;
    this.onReset = onReset;
    this.onClear = onClear;
    this.onSwap = onSwap;
    this.onDone = onDone;
    this._newColorTextLeft = this.engine.newColorTextLeft;
    this._newColorBackgroundLeft = this.engine.newColorBackgroundLeft;
    this._newColorTextRight = this.engine.newColorTextRight;
    this._newColorBackgroundRight = this.engine.newColorBackgroundRight;
    this._newLabelTextStyle = this.engine.labelTextStyle;
    this._newNumberTextStyle = this.engine.numberTextStyle;
  }

  late BuildContext context;
  late Engine engine;
  late Function onReset;
  late Function onClear;
  late Function onSwap;
  late Function onDone;

  late Color _newColorTextLeft;
  late Color _newColorBackgroundLeft;
  late Color _newColorTextRight;
  late Color _newColorBackgroundRight;

  late TextStyle _newLabelTextStyle;
  late TextStyle _newNumberTextStyle;


  void _fromEngine() async {
    setState(() {
      this._newColorTextLeft = this.engine.newColorTextLeft;
      this._newColorBackgroundLeft = this.engine.newColorBackgroundLeft;
      this._newColorTextRight = this.engine.newColorTextRight;
      this._newColorBackgroundRight = this.engine.newColorBackgroundRight;
      this._newLabelTextStyle = this.engine.labelTextStyle;
      this._newNumberTextStyle = this.engine.numberTextStyle;
    });
  }

  void _onColorTextLeftChanged(Color color) {
    this.engine.newColorTextLeft = color;
    _fromEngine();
  }

  void _onColorBackgroundLeftChanged(Color color) {
    this.engine.newColorBackgroundLeft = color;
    _fromEngine();
  }

  void _onColorTextRightChanged(Color color) {
    this.engine.newColorTextRight = color;
    _fromEngine();
  }

  void _onColorBackgroundRightChanged(Color color) {
    this.engine.newColorBackgroundRight = color;
    _fromEngine();
  }

  void colorTextLeftEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _newColorTextLeft,
              onColorChanged: _onColorTextLeftChanged,
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
              pickerColor: _newColorBackgroundLeft,
              onColorChanged: _onColorBackgroundLeftChanged,
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
              pickerColor: _newColorTextRight,
              onColorChanged: _onColorTextRightChanged,
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
              pickerColor: _newColorBackgroundRight,
              onColorChanged: _onColorBackgroundRightChanged,
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

  void fontChanged(TextStyle labelStyle, TextStyle numberStyle) async {
    this.engine.labelTextStyle = labelStyle;
    this.engine.numberTextStyle = numberStyle;
    this.onDone();
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
                    color: _newColorTextLeft,
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
                    color: _newColorBackgroundLeft,
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
                    color: _newColorTextRight,
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
                    color: _newColorBackgroundRight,
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
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                'Optional Fonts:',
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              title: new Text(
                'Default: ex. 0123456789',
                style: kLabelTextStyle.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: () => fontChanged(kLabelTextStyle, kNumberTextStyle),
            ),
            new ListTile(
              title: new Text(
                'Lato: ex. 0123456789',
                style: kLabelTextStyle_lato.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: () => fontChanged(kLabelTextStyle_lato, kNumberTextStyle_lato),
            ),
            new ListTile(
              title: new Text(
                'Merriweather: ex. 0123456789',
                style: kLabelTextStyle_merriweather.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: () => fontChanged(kLabelTextStyle_merriweather, kNumberTextStyle_merriweather),
            ),
            new ListTile(
              title: new Text(
                'Montserrat: ex. 0123456789',
                style: kLabelTextStyle_montserrat.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: () => fontChanged(kLabelTextStyle_montserrat, kNumberTextStyle_montserrat),
            ),
            new ListTile(
              title: new Text(
                'RobotoMono: ex. 0123456789',
                style: kLabelTextStyle_robotomono.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: () => fontChanged(kLabelTextStyle_robotomono, kNumberTextStyle_robotomono),
            ),
            new ListTile(
              title: new Text(
                'RockSalt: ex. 0123456789',
                style: kLabelTextStyle_rocksalt.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: () => fontChanged(kLabelTextStyle_rocksalt, kNumberTextStyle_rocksalt),
            ),
            Divider(),

          ],
        ),
      ),
    );
  }
}