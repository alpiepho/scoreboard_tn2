import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../constants.dart';
import '../engine.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SettingsModal extends StatefulWidget {
  late BuildContext context;
  late Engine engine;
  late Function onReset;
  late Function onClear;
  late Function onSwap;
  late Function onDone;
  late Function onReflector;
  late Function onComment;

  SettingsModal(
    BuildContext context,
    Engine engine,
    Function onReset,
    Function onClear,
    Function onSwap,
    Function onDone,
    Function onReflector,
    Function onComment,
  ) {
    this.context = context;
    this.engine = engine;
    this.onReset = onReset;
    this.onClear = onClear;
    this.onSwap = onSwap;
    this.onDone = onDone;
    this.onReflector = onReflector;
    this.onComment = onComment;
  }

  @override
  _SettingsModal createState() => _SettingsModal(
        context,
        engine,
        onReset,
        onClear,
        onSwap,
        onDone,
        onReflector,
        onComment,
      );
}

class _SettingsModal extends State<SettingsModal> {
  _SettingsModal(
    BuildContext context,
    Engine engine,
    Function onReset,
    Function onClear,
    Function onSwap,
    Function onDone,
    Function onReflector,
    Function onComment,
  ) {
    this.context = context;
    this.engine = engine;
    this.onReset = onReset;
    this.onClear = onClear;
    this.onSwap = onSwap;
    this.onDone = onDone;
    this.onReflector = onReflector;
    this.onComment = onComment;
    this._newColorTextLeft = this.engine.pendingColorTextLeft;
    this._newColorBackgroundLeft = this.engine.pendingColorBackgroundLeft;
    this._newColorTextRight = this.engine.pendingColorTextRight;
    this._newColorBackgroundRight = this.engine.pendingColorBackgroundRight;
  }

  late BuildContext context;
  late Engine engine;
  late Function onReset;
  late Function onClear;
  late Function onSwap;
  late Function onDone;
  late Function onReflector;
  late Function onComment;

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
      this._newColorTextLeft = this.engine.pendingColorTextLeft;
      this._newColorBackgroundLeft = this.engine.pendingColorBackgroundLeft;
      this._newColorTextRight = this.engine.pendingColorTextRight;
      this._newColorBackgroundRight = this.engine.pendingColorBackgroundRight;
    });
  }

  void _onColorTextLeftChanged(Color color) {
    this.engine.pendingColorTextLeft = color;
    _fromEngine();
  }

  void _onColorBackgroundLeftChanged(Color color) {
    this.engine.pendingColorBackgroundLeft = color;
    _fromEngine();
  }

  void _onColorTextRightChanged(Color color) {
    this.engine.pendingColorTextRight = color;
    _fromEngine();
  }

  void _onColorBackgroundRightChanged(Color color) {
    this.engine.pendingColorBackgroundRight = color;
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
            backgroundColor: Colors.white60,
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
        );
      },
      isScrollControlled: true,
    );
  }

  void onLastPointChanged() async {
    if (!this.engine.lastPointEnabled) {
      this.engine.lastPointEnabled = true;
    } else {
      this.engine.lastPointEnabled = false;
    }
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

  void onNotify8EnabledChanged() async {
    if (!this.engine.notify8Enabled) {
      this.engine.notify8Enabled = true;
    } else {
      this.engine.notify8Enabled = false;
    }
    this.onDone();
  }

  void onZoomChanged() async {
    if (!this.engine.zoom) {
      this.engine.zoom = true;
    } else {
      this.engine.zoom = false;
    }
    this.onDone();
  }

  void onKeeperListChanged(String name) async {
    name = name.replaceFirst("keeper: ", "");
    var keepers = engine.scoreKeeper.split(',');
    keepers.remove("");

    if (keepers.contains(name)) {
      keepers.remove(name);
    } else {
      keepers.add(name);
    }
    engine.scoreKeeper = keepers.join(",");
    this.onReflector();
  }

  void onReflectorListChanged(String name) async {
    engine.reflectorSite = name;
    this.onReflector();
  }

  void onSetsShowChanged() async {
    if (!this.engine.setsShow) {
      this.engine.setsShow = true;
    } else {
      this.engine.setsShow = false;
    }
    this.onDone();
  }

  void onSets5Changed() async {
    if (!this.engine.sets5) {
      this.engine.sets5 = true;
    } else {
      this.engine.sets5 = false;
    }
    this.onDone();
  }

  // TODO: these methods that change engine value should be callback functions from above
  // like for score values
  void onSetLeftIncrement() async {
    var maxSets = this.engine.sets5 ? 5 : 3;
    this.engine.setsLeft++;
    this.engine.setsLeft = min(this.engine.setsLeft, maxSets);
    this.onDone();
  }

  void onSetLeftDecriment() async {
    this.engine.setsLeft--;
    this.engine.setsLeft = max(this.engine.setsLeft, 0);
    this.onDone();
  }

  void onSetRightIncrement() async {
    var maxSets = this.engine.sets5 ? 5 : 3;
    this.engine.setsRight++;
    this.engine.setsRight = min(this.engine.setsRight, maxSets);
    this.onDone();
  }

  void onSetRightDecriment() async {
    this.engine.setsRight--;
    this.engine.setsRight = max(this.engine.setsRight, 0);
    this.onDone();
  }

  void onClearSets() async {
    this.engine.setsLeft = 0;
    this.engine.setsRight = 0;
    this.onDone();
  }

  Future<void> _launchUrl(String urlString) async {
    Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  void onReflectorSite() async {
    if (engine.reflectorSite.isNotEmpty) {
      String url = engine.reflectorSite + "/html";
      _launchUrl(url);
    }
    Navigator.of(context).pop();
  }

  // void onReflectorSiteKeeper() async {
  //   if (engine.reflectorSite.isNotEmpty && engine.scoreKeeper.isNotEmpty) {
  //     var parts = engine.scoreKeeper.split(',');
  //     var scoreKeeper = parts[0]; // just first keeper from settings page/modal
  //     String url = engine.reflectorSite + "/" + scoreKeeper + "/html";
  //     _launchUrl(url);
  //   }
  //   Navigator.of(context).pop();
  // }

  // void onScoresQR() async {
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Scores QR'),
  //         content: SingleChildScrollView(
  //           child: Container(
  //             width: 200,
  //             height: 200,
  //             child: Image.asset("assets/qr-code-scores.png"),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Done'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void onScoresTapQR() async {
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Scores Tap QR'),
  //         content: SingleChildScrollView(
  //           child: Container(
  //             width: 200,
  //             height: 200,
  //             child: Image.asset("assets/qr-code-tap.png"),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Done'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void onScoresLink() async {
  //   _launchUrl('https://alpiepho.github.io/scoreboard_tn2/');
  //   Navigator.of(context).pop();
  // }

  // void onScoresTapLink() async {
  //   _launchUrl('https://alpiepho.github.io/scoreboard_tap_tn2/');
  //   Navigator.of(context).pop();
  // }

  void onScoresHelp() async {
    _launchUrl(
        'https://github.com/alpiepho/scoreboard_tn2/blob/master/README.md');
    Navigator.of(context).pop();
  }

  void onTapHelp() async {
    _launchUrl(
        'https://github.com/alpiepho/scoreboard_tap_tn2/blob/master/README.md');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var fontString = getFontString(engine.fontType);
    var fontStyle = getLabelFont(engine.fontType);

    List<Widget> keeperTiles = [];
    var keepers = engine.scoreKeeper.split(',');
    var possibleKeepers = engine.possibleKeepers.split(',');
    for (var name in possibleKeepers) {
      var checked = keepers.contains(name);
      keeperTiles.add(
        new ListTile(
            title: new Text(
              "keeper: " + name,
              style: kSettingsTextEditStyle,
            ),
            trailing: new Icon(
              checked ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            onTap: () {
              this.onKeeperListChanged(name);
            }),
      );
    }

    List<Widget> refectorTiles = [];
    var checked = false;
    checked = (this.engine.reflectorSite == this.engine.reflectorSiteTest);
    refectorTiles.add(
      new ListTile(
          title: new Text(
            "reflector: (test)",
            style: kSettingsTextEditStyle,
          ),
          trailing: new Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onTap: () {
            this.onReflectorListChanged(this.engine.reflectorSiteTest);
          }),
    );
    checked = (this.engine.reflectorSite == this.engine.reflectorSiteDefault);
    refectorTiles.add(
      new ListTile(
          title: new Text(
            "reflector: (default)",
            style: kSettingsTextEditStyle,
          ),
          trailing: new Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onTap: () {
            this.onReflectorListChanged(this.engine.reflectorSiteDefault);
          }),
    );

    // filter shown value of reflector
    var initialValueReflector = engine.reflectorSite;
    if (initialValueReflector == engine.reflectorSiteTest) {
      initialValueReflector = "(test)";
    }
    if (initialValueReflector == engine.reflectorSiteDefault) {
      initialValueReflector = "(default)";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kSettingsModalBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        titleSpacing: 20,
        title: Text(
          "Settings",
          style: kSettingsTextEditStyle,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            SettingsDivider(),
            new ListTile(
              title: new Text(
                'Swap.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onSwap as void Function()?,
            ),
            new ListTile(
              title: new Text(
                'Add Set Left.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onSetLeftIncrement,
            ),
            new ListTile(
              title: new Text(
                'Sub Set Left.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onSetLeftDecriment,
            ),
            new ListTile(
              title: new Text(
                'Add Set Right.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onSetRightIncrement,
            ),
            new ListTile(
              title: new Text(
                'Sub Set Right.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onSetRightDecriment,
            ),
            new ListTile(
              title: new Text(
                'Clear Sets.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onClearSets,
            ),
            new ListTile(
              title: new Text(
                'Clear Scores.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onClear as void Function()?,
            ),
            SettingsDivider(),
            new ListTile(
              title: new Text(
                'Reset All.',
                style: kSettingsTextEditStyle,
              ),
              onTap: onReset as void Function()?,
            ),
            SettingsDivider(),
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                  hintText: 'Team Name',
                ),
                autofocus: false,
                initialValue: engine.labelLeft,
                onChanged: (text) => engine.pendingLabelLeft = text,
                style: kSettingsTextEditStyle,
                cursorColor: kSettingsTextEditCursorColor,
                cursorWidth: kSettingsTextEditCursorWidth,
                cursorHeight: kSettingsTextEditCursorHeight,
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onTap: colorBackgroundLeftEdit,
            ),
            SizedBox(
              height: 10,
            ),
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration:
                    new InputDecoration.collapsed(hintText: 'Team Name'),
                autofocus: false,
                initialValue: engine.labelRight,
                onChanged: (text) => engine.pendingLabelRight = text,
                style: kSettingsTextEditStyle,
                cursorColor: kSettingsTextEditCursorColor,
                cursorWidth: kSettingsTextEditCursorWidth,
                cursorHeight: kSettingsTextEditCursorHeight,
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onTap: colorBackgroundRightEdit,
            ),
            new ListTile(
              title: new Text(
                'Save Team Settings.',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.done),
              onTap: onDone as void Function()?,
            ),
            SettingsDivider(),
            new ListTile(
              title: new Text(
                'Last Point Marker.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.lastPointEnabled
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onTap: onLastPointChanged,
            ),
            new ListTile(
              title: new Text(
                'Notify at 7.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.notify7Enabled
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onTap: onNotify7EnabledChanged,
            ),
            new ListTile(
              title: new Text(
                'Notify at 8.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.notify8Enabled
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onTap: onNotify8EnabledChanged,
            ),
            new ListTile(
              title: new Text(
                'Show Sets.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.setsShow
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onTap: onSetsShowChanged,
            ),
            new ListTile(
              title: new Text(
                '5 Sets.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.sets5
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onTap: onSets5Changed,
            ),
            SettingsDivider(),
            new ListTile(
              title: new Text(
                'Change Fonts...',
                style: kSettingsTextEditStyle,
              ),
              onTap: onFontChange,
            ),
            new ListTile(
              title: new Text(
                fontString,
                style:
                    fontStyle.copyWith(fontSize: kSettingsTextStyle_fontSize),
              ),
              // onTap: onFontChange,
            ),
            new ListTile(
              title: new Text(
                'Zoom.',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(engine.zoom
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onTap: onZoomChanged,
            ),
            SettingsDivider(),
            new ListTile(
              title: new Text(
                "Reflector Settings:",
                style: kSettingsTextEditStyle,
              ),
            ),
            // ...keeperTiles,
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Add new scorekeeper'),
                autofocus: false,
                initialValue: engine.scoreKeeper,
                onChanged: (text) {
                  // can be comma separated list or *
                  engine.scoreKeeper = text.trim().replaceAll(' ', ',');
                },
                style: kSettingsTextEditStyle,
                cursorColor: kSettingsTextEditCursorColor,
                cursorWidth: kSettingsTextEditCursorWidth,
                cursorHeight: kSettingsTextEditCursorHeight,
              ),
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
              title: new Text(
                'Save New Scorekeeper.',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.done),
              onTap: onReflector as void Function()?,
            ),
            ...refectorTiles,
            new ListTile(
              leading: null,
              title: new TextFormField(
                decoration: new InputDecoration.collapsed(
                    hintText: 'Add Other Reflector'),
                autofocus: false,
                initialValue: initialValueReflector,
                onChanged: (text) => engine.reflectorSite = text,
                style: kSettingsTextEditStyle,
                cursorColor: kSettingsTextEditCursorColor,
                cursorWidth: kSettingsTextEditCursorWidth,
                cursorHeight: kSettingsTextEditCursorHeight,
              ),
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
              title: new Text(
                'Save Other Reflector.',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.done),
              onTap: onReflector as void Function()?,
            ),
            SettingsDivider(),
            new ListTile(
              leading: null,
              title: new TextFormField(
                maxLines: 4,
                minLines: 4,
                decoration: new InputDecoration.collapsed(
                    hintText: 'Add a Reflector comment here'),
                autofocus: false,
                initialValue: engine.reflectorComment,
                onChanged: (text) => engine.reflectorComment = text,
                style: kSettingsTextEditStyle,
                cursorColor: kSettingsTextEditCursorColor,
                cursorWidth: kSettingsTextEditCursorWidth,
                cursorHeight: kSettingsTextEditCursorHeight,
              ),
              trailing: new Icon(Icons.edit),
            ),
            new ListTile(
              title: new Text(
                'Send Comment.',
                style: kSettingsTextEditStyle,
              ),
              //trailing: new Icon(Icons.done),
              onTap: onComment as void Function()?,
            ),
            SettingsDivider(),
            new ListTile(
              title: new Text(
                'Reflector Site...',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.help),
              onTap: onReflectorSite,
            ),
            // new ListTile(
            //   title: new Text(
            //     'Reflector Keeper...',
            //     style: kSettingsTextEditStyle,
            //   ),
            //   trailing: new Icon(Icons.help),
            //   onTap: onReflectorSiteKeeper,
            // ),
            SettingsDivider(),
            new ListTile(
              title: new Text(
                kVersion,
                style: kSettingsTextEditStyle,
              ),
            ),
            // new ListTile(
            //   title: new Text(
            //     'Scores QR...',
            //     style: kSettingsTextEditStyle,
            //   ),
            //   trailing: new Icon(Icons.help),
            //   onTap: onScoresQR,
            // ),
            // new ListTile(
            //   title: new Text(
            //     'Scores Tap QR...',
            //     style: kSettingsTextEditStyle,
            //   ),
            //   trailing: new Icon(Icons.help),
            //   onTap: onScoresTapQR,
            // ),
            // new ListTile(
            //   title: new Text(
            //     'Scores Link...',
            //     style: kSettingsTextEditStyle,
            //   ),
            //   trailing: new Icon(Icons.help),
            //   onTap: onScoresLink,
            // ),
            // new ListTile(
            //   title: new Text(
            //     'Scores Tap Link...',
            //     style: kSettingsTextEditStyle,
            //   ),
            //   trailing: new Icon(Icons.help),
            //   onTap: onScoresTapLink,
            // ),
            new ListTile(
              title: new Text(
                'TapTN2 Help...',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.help),
              onTap: onTapHelp,
            ),
            new ListTile(
              title: new Text(
                'Help...',
                style: kSettingsTextEditStyle,
              ),
              trailing: new Icon(Icons.help),
              onTap: onScoresHelp,
            ),
            SettingsDivider(),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 2,
    );
  }
}
