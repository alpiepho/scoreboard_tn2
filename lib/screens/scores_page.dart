import 'package:flutter/material.dart';
import 'package:scoreboard_tn2/components/score_card.dart';
import 'package:scoreboard_tn2/components/score_card_content.dart';
import 'package:scoreboard_tn2/components/settings_button.dart';
import 'package:scoreboard_tn2/components/settings_modal.dart';
import 'package:scoreboard_tn2/constants.dart';
import 'package:scoreboard_tn2/engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey _keyPortraitLeft = GlobalKey();
GlobalKey _keyPortraitRight = GlobalKey();
GlobalKey _keyLandscapeLeft = GlobalKey();
GlobalKey _keyLandscapeRight = GlobalKey();

class ScoresPage extends StatefulWidget {
  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {
  //
  // for display
  //
  Color _colorTextLeft = Colors.black;
  Color _colorBackgroundLeft = Colors.red;
  Color _colorTextRight = Colors.black;
  Color _colorBackgroundRight = Colors.blueAccent;

  String _labelLeft = "Away";
  String _labelRight = "Home";
  int _valueLeft = 0;
  int _valueRight = 0;

  FontTypes _fontType = FontTypes.system;

  // for increment/decrement swiping
  double _panPositionYLeft = 0.0;
  double _panPositionYRight = 0.0;

  Engine _engine = Engine();

  void _loadEngine() async {
    final prefs = await SharedPreferences.getInstance();
    var packed = prefs.getString('engine') ?? "";
    _engine.unpack(packed);
    _fromEngine();
  }

  void _saveEngine() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('engine', _engine.pack());
  }

  void _fromEngine() async {
    setState(() {
      _labelLeft = this._engine.getLabelLeft();
      _labelRight = this._engine.getLabelRight();
      _valueLeft = this._engine.valueLeft;
      _valueRight = this._engine.valueRight;

      _colorTextLeft = this._engine.colorTextLeft;
      _colorBackgroundLeft = this._engine.colorBackgroundLeft;
      _colorTextRight = this._engine.colorTextRight;
      _colorBackgroundRight = this._engine.colorBackgroundRight;

      _fontType = this._engine.fontType;
    });
  }

  void _incrementLeft() async {
    this._engine.incrementLeft();
    _fromEngine();
    _notify7();
    _notify8();
  }

  void _decrementLeft() async {
    this._engine.decrementLeft();
    _fromEngine();
  }

  void _incrementRight() async {
    this._engine.incrementRight();
    _fromEngine();
    _notify7();
    _notify8();
  }

  void _decrementRight() async {
    this._engine.decrementRight();
    _fromEngine();
  }

  void _clearBoth() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Clear Scores',
            style: kSettingsTextEditStyle,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Would you clear scores?',
                  style: kSettingsTextEditStyle,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style:
                    kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Clear',
                style:
                    kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
              ),
              onPressed: () {
                this._engine.clearBoth();
                _fromEngine();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetBoth() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Reset All',
            style: kSettingsTextEditStyle,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you reset everything?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style:
                    kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Reset',
                style:
                    kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
              ),
              onPressed: () {
                this._engine.resetBoth();
                _fromEngine();
                _saveEngine();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _swapTeams() async {
    this._engine.swapTeams();
    _fromEngine();
    _saveEngine();
    Navigator.of(context).pop();
  }

  void _savePending() async {
    this._engine.savePending();
    _fromEngine();
    _saveEngine();
    Navigator.of(context).pop();
  }

  void _panUpdateLeft(DragUpdateDetails details) async {
    // use swipe to adjust score
    if (details.delta.dy.abs() > 1) {
      _panPositionYLeft += details.delta.dy;
      if (_panPositionYLeft < -100) {
        _panPositionYLeft = 0.0;
        _incrementLeft();
      } else if (_panPositionYLeft > 100) {
        _panPositionYLeft = 0.0;
        _decrementLeft();
      }
    } else {
      _panPositionYLeft = 0.0;
    }
  }

  void _panUpdateRight(DragUpdateDetails details) async {
    // use swipe to adjust score
    if (details.delta.dy.abs() > 1) {
      _panPositionYRight += details.delta.dy;
      if (_panPositionYRight < -100) {
        _panPositionYRight = 0.0;
        _incrementRight();
      } else if (_panPositionYRight > 100) {
        _panPositionYRight = 0.0;
        _decrementRight();
      }
    } else {
      _panPositionYRight = 0.0;
    }
  }

  void _notify7() async {
    if (this._engine.notify7()) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'At 7 Points',
              style: kSettingsTextEditStyle,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Would you swap teams?',
                    style: kSettingsTextEditStyle,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style:
                      kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Swap',
                  style:
                      kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
                ),
                onPressed: () {
                  this._engine.swapTeams();
                  _fromEngine();
                  _saveEngine();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _notify8() async {
    if (this._engine.notify8()) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'At 8 Points',
              style: kSettingsTextEditStyle,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Would you swap teams?',
                    style: kSettingsTextEditStyle,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style:
                      kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Swap',
                  style:
                      kSettingsTextEditStyle.copyWith(color: Colors.blueAccent),
                ),
                onPressed: () {
                  this._engine.swapTeams();
                  _fromEngine();
                  _saveEngine();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  initState() {
    super.initState();
    _loadEngine();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle = kLabelTextStyle_system;
    TextStyle numberTextStyle = kNumberTextStyle_system;

    labelTextStyle = getLabelFont(_fontType);
    numberTextStyle = getNumberFont(_fontType);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    //var forcePortrait = this._engine.forceLandscape && isPortrait;
    var forcePortrait = isPortrait;

    return Scaffold(
      backgroundColor: kInputPageBackgroundColor,
      body: Center(
        child: Stack(
          children: [
            Visibility(
              visible: isPortrait,
              child: Container(
                width: kMainContainerWidthPortrait,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            key: _keyPortraitLeft,
                            child: TeamScoreCard(
                              onPress: _incrementLeft,
                              onPan: _panUpdateLeft,
                              color: _colorBackgroundLeft,
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                              portrait: forcePortrait,
                              cardChild: TeamScoreCardContent(
                                label: _labelLeft,
                                textStyle: labelTextStyle,
                                colorText: _colorTextLeft,
                                value: _valueLeft,
                                numberTextStyle: numberTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            key: _keyPortraitRight,
                            child: TeamScoreCard(
                              onPress: _incrementRight,
                              onPan: _panUpdateRight,
                              color: _colorBackgroundRight,
                              margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              portrait: forcePortrait,
                              cardChild: TeamScoreCardContent(
                                label: _labelRight,
                                textStyle: labelTextStyle,
                                colorText: _colorTextRight,
                                value: _valueRight,
                                numberTextStyle: numberTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !isPortrait,
              child: Container(
                width: kMainContainerWidthLandscape,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            key: _keyLandscapeLeft,
                            child: TeamScoreCard(
                              onPress: _incrementLeft,
                              onPan: _panUpdateLeft,
                              color: _colorBackgroundLeft,
                              margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                              portrait: forcePortrait,
                              cardChild: TeamScoreCardContent(
                                label: _labelLeft,
                                textStyle: labelTextStyle,
                                colorText: _colorTextLeft,
                                value: _valueLeft,
                                numberTextStyle: numberTextStyle,
                              ),
                            ),
                          ),
                          Expanded(
                            key: _keyLandscapeRight,
                            child: TeamScoreCard(
                              onPress: _incrementRight,
                              onPan: _panUpdateRight,
                              color: _colorBackgroundRight,
                              margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                              portrait: forcePortrait,
                              cardChild: TeamScoreCardContent(
                                label: _labelRight,
                                textStyle: labelTextStyle,
                                colorText: _colorTextRight,
                                value: _valueRight,
                                numberTextStyle: numberTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SettingsButton(onPress: () {
        this._engine.setPending();
        showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SettingsModal(
              context,
              this._engine,
              _resetBoth,
              _clearBoth,
              _swapTeams,
              _savePending,
            );
          },
          isScrollControlled: true,
        );
      }),
      floatingActionButtonLocation: (forcePortrait
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat),
    );
  }
}
