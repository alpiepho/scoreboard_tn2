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

    selectedRate = this.engine.recordingRate;
    allRates = this.engine.getRates();
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

  void onTimestampRecordingRateChange() async {
    showMaterialScrollPicker(
      //backgroundColor: kInputPageBackgroundColor,
      headerColor: kInputPageBackgroundColor,
      showDivider: false,
      context: context,
      title: "Rate",
      items: allRates,
      selectedItem: selectedRate,
      onChanged: (value) {
        setState(() {
          selectedRate = value;
          this.engine.recordingRate = value;
        });
      },
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

  void onTimestampRecordingStart() async {
    this.engine.timestampRecordingStart();
    Navigator.of(context).pop();
  }

  void onTimestampRecordingStop() async {
    this.engine.timestampRecordingStop();
    Navigator.of(context).pop();
  }

  void onTimestampRecordingShowText() async {
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
            title: Text("Recording Text"),
            actions: [],
          ),
          body: Container(
            child: new SingleChildScrollView (
              scrollDirection: Axis.vertical,
              child: new Text(
                engine.timestampRecordingCopy(),
              ),
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

  void onTimestampRecordingCopy() async {
    String contents = this.engine.timestampRecordingCopy();
    Clipboard.setData(ClipboardData(text: contents));
    Navigator.of(context).pop();
  }

  void onTimestampPasteYouTube(String text) async {
    engine.recordingYTLink = text;
     Navigator.of(context).pop();
  }

  void onTimestampPasteRecording(String text) async {
    engine.recording = text;
    Navigator.of(context).pop();
  }

  void onTimestampRecordingShowLinks() async {
    //TODO: later, add as links like help
    var lines = engine.timestampRecordingYTText().split("\n");
    List<TextSpan> tspans = [];
    for (var line in lines) {
      var span = new TextSpan(
                  text: line+"\n",
                  style: new TextStyle(color: Colors.black),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch(line);
                  },
      );
      tspans.add(span);
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
            title: Text("Recording Text"),
            actions: [],
          ),
          body: Container(
            child: new SingleChildScrollView (
              scrollDirection: Axis.vertical,
              child: new RichText(
            text: new TextSpan(
              children: tspans,
            ),
          ),
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
            Divider(),
            new ListTile(
              title: new Text(
                'Reset All...^',
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
                'Record Timestamps:',
                style: kSettingsTextEditStyle,
              ),
            ),
            new ListTile(
              title: new Text(
                'Rate...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Text(
                selectedRate,
                style: kSettingsTextEditStyle,
              ),
              onTap: onTimestampRecordingRateChange,
            ),
            new ListTile(
              title: new Text(
                'Start...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.recordingEnabled ? Icons.check_box : Icons.check_box_outline_blank),
              onTap: onTimestampRecordingStart,
            ),
            new ListTile(
              title: new Text(
                'Stop...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.call_end),
              onTap: onTimestampRecordingStop,
            ),
            new ListTile(
              title: new Text(
                'Show as Text...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.library_books),
              onTap: onTimestampRecordingShowText,
            ),
            new ListTile(
              title: new Text(
                'Copy to Clipboard...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.library_books),
              onTap: onTimestampRecordingCopy,
            ),
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Paste Youtube Link...'
                ),
                autofocus: false,
                keyboardType: TextInputType.number,
                onChanged: (text) => { onTimestampPasteYouTube(text) },
              ),
              trailing: Container(
                width: 200,
                child: new Text(
                  engine.recordingYTLink,
                  //style: kSettingsTextEditStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
           ),
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Paste Previous Recording...'
                ),
                autofocus: false,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (text) => { onTimestampPasteRecording(text) },
              ),
              trailing: Container(
                width: 200,
                child: new Text(
                  engine.recording,
                  //style: kSettingsTextEditStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
           ),
           new ListTile(
              title: new Text(
                'Show YouTube Links...^',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.library_books),
              onTap: onTimestampRecordingShowLinks,
            ),
            Divider(),
            Divider(),
            Divider(),
            Divider(),
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
