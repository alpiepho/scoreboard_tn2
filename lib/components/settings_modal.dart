import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:scoreboard_tn/engine.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: must_be_immutable
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

  //late var selectedFont = "";
  //late List<String> allFonts;


  late var selectedRate;
  late List<String> allRates;


  void _fromEngine() async {
    setState(() {
      this._newColorTextLeft = this.engine.newColorTextLeft;
      this._newColorBackgroundLeft = this.engine.newColorBackgroundLeft;
      this._newColorTextRight = this.engine.newColorTextRight;
      this._newColorBackgroundRight = this.engine.newColorBackgroundRight;
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

  void fontChanged(FontTypes fontType) async {
    this.engine.fontType = fontType;
    Navigator.of(context).pop();
    this.onDone();
  }

  void onFontChange() async {
    List<Widget> widgets = [];
    for (var value in FontTypes.values) {
      var style = getLabelFont(value);
      var tile = new ListTile(
                    title: new Text(
                      getFontString(value),
                      style: style.copyWith(fontSize: kSettingsTextStyle_fontSize),
                    ),
                    onTap: () => fontChanged(value),
                    trailing: new Icon(engine.fontType == value ? Icons.check : null),
                  );
      widgets.add(tile);
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kSettingsModalBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            toolbarHeight: 50,
            titleSpacing: 20,
            title: Text("Settings"),
            actions: [],
          ),
          body: Container(
              child: ListView(
                children: widgets,
              ),
            ),
          // context,
          // this._engine,
          // _resetBoth,
          // _clearBoth,
          // _swapTeams,
          // _saveBoth,
        );
      },
      isScrollControlled: true,
    );
  }

  void onEarnedEnabledChanged() async {
    if (!this.engine.earnedEnabled) {
      this.engine.earnedEnabled = true;
      this.engine.earnedVisible = true;
    } else {
      this.engine.earnedEnabled = false;
      this.engine.earnedVisible = false;
    }
    this.onDone();
  }
  void onEarnedVisibleChanged() async {
    this.engine.earnedVisible = !this.engine.earnedVisible;
    this.onDone();
  }


  void onNotify7EnabledChanged() async {
    if (!this.engine.notify7Enabled) {
      this.engine.notify7Enabled = true;
    } else {
      this.engine.notify7Enabled = false;
    }
    this.onDone();
  }

  void onHelp() async {
    launch('https://github.com/alpiepho/scoreboard_tn');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var fontString = getFontString(engine.fontType);
    var fontStyle = getLabelFont(engine.fontType);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kSettingsModalBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        titleSpacing: 20,
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Divider(),
            new ListTile(
              title: new Text(
                'Swap^',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.swap_horiz),
              onTap: onSwap as void Function()?,
            ),
            new ListTile(
              title: new Text(
                'Clear Scores^',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.undo),
              onTap: onClear as void Function()?,
            ),
            Divider(),
            new ListTile(
              title: new Text(
                'Reset All...^',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.clear_all),
              onTap: onReset as void Function()?,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
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
              trailing: new Icon(Icons.edit),
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
              trailing: new Icon(Icons.edit),
           ),
            new ListTile(
              title: new Text(
                'Text Color...',
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
                'Background Color...',
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
              trailing: new Icon(Icons.edit),
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
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
              title: new Text(
                'Text Color...',
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
                'Background Color...',
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
            new ListTile(
              title: new Text(
                'Done^',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.done),
              onTap: onDone as void Function()?,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                'Notify at 7...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.notify7Enabled ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onNotify7EnabledChanged,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                'Track Earned Points...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.earnedEnabled ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onEarnedEnabledChanged,
            ),
            new ListTile(
              title: new Text(
                'Show Earned Points...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.earnedVisible ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onEarnedVisibleChanged,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                'Change Fonts...^',
                style: kSettingsTextEditStyle,
              ),
              onTap: onFontChange,
            ),
            new ListTile(
              title: new Text(
                fontString,
                style: fontStyle.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              onTap: onFontChange,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
            new ListTile(
              title: new Text(
                'Version: 0.3',
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              title: new Text(
                'Help...',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.help),
              onTap: onHelp,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
          ],
        ),
      ),
    );
  }
}
